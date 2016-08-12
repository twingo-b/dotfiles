# vim: set ft=zsh
#=#=#=
# Colorize some applications outputs
#
# * diff aliased to colordiff
# * tree -C
# * grep
#=#=

autoload -U colors && colors

## Alias

# colordiff
# http://qiita.com/catatsuy/items/8bafef2a60762a1c9f0f
if [[ -x `which colordiff` ]]; then
	alias diff='colordiff -u'
else
	alias diff='diff -u'
fi

alias tree='tree -C'

alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"

# ターミナルで256色表示できているか確認する関数
# http://qiita.com/items/160a13a95e9627a55750
function 256colortest() {
    local code
    for code in {0..255}; do
        echo -e "\e[38;05;${code}m $code: Test"
    done
}
