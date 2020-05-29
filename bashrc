#==========================================================================
# My personal $HOME/.bashrc config FILE
#==========================================================================

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export TERM=xterm-256color
export EDITOR="nvim"

#--------------------------------------------------------------------------
# Enable options
#--------------------------------------------------------------------------

shopt -s histappend	# append to history file, don't overwrite
shopt -s checkwinsize	# check windowsize after each command, update line/col values
shopt -s cdspell	# cd argument spellcheck
shopt -s cdable_vars	# treat nondir arg to cd as a variable whose value is the dir to go to
shopt -s checkhash	# check hash table commands still exist before use, if not use normal PATH search
shopt -s sourcepath	# search $PATH for file and then look in current dir
shopt -s cmdhist	# save all lines of multiline command in one history entry
shopt -s globstar	# pattern "**" in pathname extension will match all files
			# and zero or more dirs and sub-dirs

# History
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1=' \w → '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

#==========================================================================
# Aliases
#==========================================================================

#--------------------------------------------------------------------------
# Color support
#--------------------------------------------------------------------------

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#--------------------------------------------------------------------------
# Basic commands
#--------------------------------------------------------------------------

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias mv='mv -i'
alias rm='rm -i'

#--------------------------------------------------------------------------
# Package management
#--------------------------------------------------------------------------

alias update='sudo apt-get update'
alias upgrade='sudo apt-get upgrade'
alias install='sudo apt-get install'
alias remove='sudo apt-get remove'

#--------------------------------------------------------------------------
# Dotfiles
#--------------------------------------------------------------------------

alias bashrc='sudo ~/nvim.appimage ~/dotfiles/bashrc'
alias vimrc='sudo ~/nvim.appimage ~/dotfiles/init.vim'
alias tmuxrc='sudo ~/nvim.appimage ~/dotfiles/tmux-conf'
alias alacrittyrc='sudo ~/nvim.appimage ~/dotfiles/alacritty.yml'
alias vifmrc='sudo ~/nvim.appimage ~/dotfiles/vifmrc' 

#--------------------------------------------------------------------------
# Tools
#--------------------------------------------------------------------------

alias jn='jupyter notebook'
alias vim='~/nvim.appimage'
alias nvim='~/nvim.appimage'

#--------------------------------------------------------------------------
# Git
#--------------------------------------------------------------------------

alias gs='git status'
alias gpom='git push origin master'
alias ga='git add'
alias gc='git commit -m'
alias gs='git status'
alias gphm="git push heroku master"

#--------------------------------------------------------------------------
# Twitter dev app
#--------------------------------------------------------------------------

alias botdir='cd $HOME/Twitter_Dev_App/Academic_Chatter'
alias boton=acon
alias botoff=acoff
alias botchange='git add .; git commit -m "test"; git push heroku master'

#==========================================================================
# Functions
#==========================================================================

function acon()		# turn AC dev app on (from any dir)
{
	if [ $PWD != '/home/jon/Twitter_Dev_App/Academic_Chatter' ];
	then 
		cd '/home/jon/Twitter_Dev_App/Academic_Chatter'; heroku ps:scale worker=1; cd - > /dev/null 2>&1
	else
		heroku ps:scale worker=1
	fi
}

function acoff()	# turn AC dev app off (from any dir)
{
	if [ $PWD != '/home/jon/Twitter_Dev_App/Academic_Chatter' ];
	then 
		cd '/home/jon/Twitter_Dev_App/Academic_Chatter'; heroku ps:scale worker=0; cd - > /dev/null 2>&1
	else
		heroku ps:scale worker=0
	fi
}

function extract()      # Auto extraction
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.tar.xz)    tar -xf $1      ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Copy and go to the directory
cpg ()
{
	if [ -d "$2" ];then
		cp $1 $2 && cd $2
	else
		cp $1 $2
	fi
}

# Move and go to the directory
mvg ()
{
	if [ -d "$2" ];then
		mv $1 $2 && cd $2
	else
		mv $1 $2
	fi
}

# Create and go to the directory
mkdirg ()
{
	mkdir -p $1
	cd $1
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# enable middle mouse button (scroll wheel for pasting)
synclient TapButton3=2

source /home/jon/.config/broot/launcher/bash/br

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
