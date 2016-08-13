let s:plug_dir = expand('~/.vim/plugged')
let s:plug_source = expand('~/.vim/autoload/plug.vim')

if !filereadable(s:plug_source)
  execute '! curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin(s:plug_dir)

Plug 'surround.vim'
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

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_theme='papercolor'
let g:airline_powerline_fonts = 1

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
