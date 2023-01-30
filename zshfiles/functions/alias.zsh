# enable color support of ls and also add handy aliases
alias ls='ls -G'
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

# MacVim Kaoriya
# http://qiita.com/biraty22/items/e7b7369b025aecc711f3
alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias vim='env_LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias g='cd $(ghq root)/$(ghq list | peco)'
alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
alias aws-v2='finch run --rm -ti -v ~/.aws:/root/.aws -v "$(readlink -f ~/.aws/config)":/root/.aws/config -v "$(readlink -f ~/.aws/credentials)":/root/.aws/credentials -v $(pwd):/aws -v ~/.ssh:/root/.ssh -v "$(readlink -f ~/.ssh/config)":/root/.ssh/config $(for _e in AWS_PAGER AWS_ACCESS_KEY_ID AWS_CA_BUNDLE AWS_CONFIG_FILE AWS_DEFAULT_OUTPUT AWS_DEFAULT_REGION AWS_PROFILE AWS_ROLE_SESSION_NAME AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_SHARED_CREDENTIALS_FILE;do if [ "x$(eval echo \$$_e)" != "x" ];then echo -n " --env $(echo ${_e})=$(eval echo \$$_e) ";fi;done) amazon/aws-cli'
