let s:plug_dir = expand('~/.vim/plugged')
let s:plug_source = expand('~/.vim/autoload/plug.vim')

if !filereadable(s:plug_source)
  execute '! curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin(s:plug_dir)

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'Shougo/unite.vim'
nnoremap <silent> <Leader>uy :<C-u>Unite history/yank<CR>
nnoremap <silent> <Leader>ub :<C-u>Unite buffer<CR>
nnoremap <silent> <Leader>uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <Leader>ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> <Leader>uu :<C-u>Unite file_mru buffer<CR>

Plug 'Shougo/vimfiler.vim'
nnoremap <silent> <Leader>e :VimFilerBufferDir -buffer-name=explorer -split

Plug 'Shougo/vimproc', {'do': 'make'}
Plug 'ctrlpvim/ctrlp.vim'
if executable('ag')
  let g:ctrlp_user_command='ag %s -i --nocolor --nogroup -g ""'
endif
nnoremap <Leader>oo :CtrlP<CR>
nnoremap <Leader>om :CtrlPMixed<CR>
nnoremap <Leader>or :CtrlPMRUFiles<CR>

Plug 'ervandew/supertab'
Plug 'tacroe/unite-mark'
Plug 'kshenoy/vim-signature'
let g:unite_source_mark_marks =
      \   "abcdefghijklmnopqrstuvwxyz"
      \ . "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
      \ . "0123456789.'`^<>[]{}()\""

nnoremap <silent> `` :Unite mark<CR>
nnoremap <silent> '' :Unite mark<CR>

let g:SignatureMartTextHLDynamic = 1
let g:SignatureMarkTextHL = "SignColumn"

Plug 'LeafCage/foldCC'
set foldtext=FoldCCtext()

Plug 'lilydjwg/colorizer'
Plug 'tyru/open-browser.vim'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'"{{{
" http://qiita.com/yuyuchu3333/items/20a0acfe7e0d0e167ccc
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [
        \     ['mode', 'paste'],
        \     ['fugitive', 'gitgutter', 'filename'],
        \   ],
        \   'right': [
        \     ['lineinfo', 'syntastic'],
        \     ['percent'],
        \     ['charcode', 'fileformat', 'fileencoding', 'filetype'],
        \   ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode',
        \   'syntastic': 'SyntasticStatuslineFlag',
        \   'charcode': 'MyCharCode',
        \   'gitgutter': 'MyGitGutter',
        \ },
        \ 'separator': {'left': '⮀', 'right': '⮂'},
        \ 'subseparator': {'left': '⮁', 'right': '⮃'}
        \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &ro ? '⭤' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? '⭠ '._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth('.') > 60 ? lightline#mode() : ''
endfunction

function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

" https://github.com/Lokaltog/vim-powerline/blob/develop/autoload/Powerline/Functions.vim
function! MyCharCode()
  if winwidth('.') <= 70
    return ''
  endif

  " Get the output of :ascii
  redir => ascii
  silent! ascii
  redir END

  if match(ascii, 'NUL') != -1
    return 'NUL'
  endif

  " Zero pad hex values
  let nrformat = '0x%02x'

  let encoding = (&fenc == '' ? &enc : &fenc)

  if encoding == 'utf-8'
    " Zero pad with 4 zeroes in unicode files
    let nrformat = '0x%04x'
  endif

  " Get the character and the numeric value from the return value of :ascii
  " This matches the two first pieces of the return value, e.g.
  " "<F>  70" => char: 'F', nr: '70'
  let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

  " Format the numeric value
  let nr = printf(nrformat, nr)

  return "'". char ."' ". nr
endfunction
set laststatus=2
"}}}

Plug 'thinca/vim-quickrun'
let g:quickrun_config = {}
let g:quickrun_no_default_key_mapping = 0

Plug 'tpope/vim-markdown', {'for': 'markdown'}
Plug 'tyru/markdown-codehl-onthefly.vim', {'for': 'markdown'}

Plug 'davidhalter/jedi-vim', {'for': 'python'}
let g:jedi#popup_on_dot = 1
let g:jedi#popup_select_first = 1

Plug 'tmhedberg/SimpylFold', {'for': 'python'}
Plug 'nvie/vim-flake8', {'for': 'python'}
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}

Plug 'mattn/webapi-vim'
Plug 'mattn/googlesuggest-complete-vim'
Plug 'rking/ag.vim'

Plug 'altercation/vim-colors-solarized'

call plug#end()


" Required:
filetype plugin indent on
syntax on
set background=dark
colorscheme solarized


"---------------------------------------------------------------------------}}}
