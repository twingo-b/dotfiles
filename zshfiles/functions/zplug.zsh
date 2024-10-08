# zplug
# https://github.com/zplug/zplug
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

zplugs=() # Reset zplugs
zplug "ssh0/dot", use:"*.sh"
zplug "b4b4r07/enhancd", use:init.sh
zplug "Tarrasch/zsh-bd"
zplug "chrissicool/zsh-256color"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "b4b4r07/zsh-vimode-visual", defer:3

# Then, source plugins and add commands to $PATH
# zplug load --verbose
zplug load

