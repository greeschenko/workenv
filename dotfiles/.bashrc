export TERM=xterm-256color        # for common 256 color terminals (e.g. gnome-terminal)
#export TERM=rxvt-unicode-256color # for a colorful rxvt unicode session

# bash options
shopt -s autocd         # change to named directory
#shopt -s cdable_vars    # if cd arg is not valid, assumes its a var defining a dir
#shopt -s cdspell        # autocorrects cd misspellings
shopt -s checkwinsize   # update the value of LINES and COLUMNS after each command if altered
shopt -s cmdhist        # save multi-line commands in history as single line
shopt -s dotglob        # include dotfiles in pathname expansion
shopt -s expand_aliases # expand aliases
shopt -s extglob        # enable extended pattern-matching features
shopt -s histappend     # append to (not overwrite) the history file
shopt -s hostcomplete   # attempt hostname expansion when @ is at the beginning of a word
shopt -s nocaseglob     # pathname expansion will be treated as case-insensitive

# if not running interactively, don't do anything
[ -z "$PS1" ] && return


# Define color variables
Color_Off='\[\033[0m\]'         # Text Reset

# Regular Colors
Black='\[\033[0;30m\]'    # Black
Red='\[\033[0;31m\]'      # Red
Green='\[\033[0;32m\]'    # Green
Yellow='\[\033[0;33m\]'   # Yellow
Blue='\[\033[0;34m\]'     # Blue
Purple='\[\033[0;35m\]'   # Purple
Cyan='\[\033[0;36m\]'     # Cyan
White='\[\033[0;37m\]'    # White

# Bold
BGrey='\[\033[1;30m\]'   # Grey
BRed='\[\033[1;31m\]'     # Red
BGreen='\[\033[1;32m\]'   # Green
BYellow='\[\033[1;33m\]'  # Yellow
BBlue='\[\033[1;34m\]'    # Blue
BPurple='\[\033[1;35m\]'  # Purple
BCyan='\[\033[1;36m\]'    # Cyan
BWhite='\[\033[1;37m\]'   # White
BWhiteOnBlue='\[\033[1;37;44m\]'   # White
BWhiteOnRed='\[\033[1;37;41m\]'   # White
BWhiteOnYellow='\[\033[1;37;43m\]'   # White
BYellowOnBlue='\[\033[0;33;44m\]'   # White
BWhiteOnBlack='\[\033[1;37;40m\]'   # White
BBlackOnRed='\[\033[0;30;41m\]'   # White

if [ "$USER" == "root" ]; then
    user_color="${Red}"
    end_color="${Red}"
    dir_color="${Cyan}"
    dir_color_end="${BBlackOnRed}"
else
    user_color="${BWhiteOnBlue}"
    end_color="${Blue}"
    dir_color="${Cyan}"
    dir_color_end="${BYellowOnBlue}"
fi

#export PS1="\n\[\e[35m\]\u\[\e[m\]@\h:\[\e[36m\]\w\[\e[m\]\n\[\e[35m\]:\[\e[m\]\n\[\e[35m\]:\[\e[m\]\n\[\e[35m\]:::::::\[\e[m\] "
export PS1="\n\w\n\[\e[35m\]:::::\[\e[m\] "

#PS1="${dir_color} \w ${user_color} \u $"

#export PS1="\n\[$(tput sgr0)\]\[\033[38;5;8m\]  \w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;167m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\] >> \[$(tput sgr0)\]"
unset user_color

# set vim as default editor
export EDITOR="vim"
export FCEDIT="vim"
export VISUAL=$EDITOR

# set default browser
if [ -z "$DISPLAY" ]; then
    export BROWSER="links"
else
    export BROWSER="chromium"
fi

# set history variables
export HISTFILESIZE="1000"
export HISTCONTROL="ignoredups"

# share history across all terminals
PROMPT_COMMAND="history -a"

# colour coreutils
eval $(dircolors -b ~/.dir_colors)

# bash completion
set show-all-if-ambiguous on

# ~/.bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ~/.bash_functions
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# less colors for man pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # начало мерцающего стиля
export LESS_TERMCAP_md=$'\E[01;38;5;11m'  # начало полужирного стиля
export LESS_TERMCAP_me=$'\E[0m'           # окончание мерцающего или полужирного стиля
export LESS_TERMCAP_so=$'\E[38;5;246m'    # начало служебной информации
export LESS_TERMCAP_se=$'\E[0m'           # окончание служебной информации
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # начало подчеркивания
export LESS_TERMCAP_ue=$'\E[0m'           # окончание подчеркивания

stty -ixon
#export TERM=screen-256color

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
