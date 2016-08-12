# zplug
# https://github.com/zplug/zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "ssh0/dot", use:"*.sh"
zplug "b4b4r07/enhancd", use:init.sh
zplug "Tarrasch/zsh-bd"
zplug "chrissicool/zsh-256color"
zplug "zsh-users/zsh-syntax-highlighting", nice:10

# Then, source plugins and add commands to $PATH
zplug load --verbose

