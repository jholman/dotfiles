# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

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
force_color_prompt=yes

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
#alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
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





##### JJWH EDITS START HERE


export VISUAL=vi
export EDITOR=vi

umask 022



# Fuck Debian's idiotic opinionated color-prompt bullshit.
# I've decided to put this down here to make sure ALL my edits are down here.
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then	# this is their code to check for color support
    # color prompt
    # also includes \[\033]0;\w\a\] for changing terminal title
    PS1='\n${debian_chroot:+($debian_chroot) }\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ \[\033]0;\w\a\]'
else
    # shitty prompt
    PS1='\n${debian_chroot:+($debian_chroot) }\u@\h:\w\$ '
fi

# set PATH so it includes user's private bin if it exists
# TODO: check whether this is double-executing with .profile
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"

    # see https://git-scm.com/book/en/v1/Git-Basics-Tips-and-Tricks#Auto-Completion
    if [ -f $HOME/bin/git-completion.bash ] ; then
      source $HOME/bin/git-completion.bash
    fi
fi

shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

HISTSIZE=10000
HISTFILESIZE=20000


# immediate writes to .bash_history
PROMPT_COMMAND='history -a;'
#PROMPT_COMMAND='history -a; echo -en "\033]0;${PWD/#$HOME/'"'~'"'}\a"'       # this is a working-but-complicated terminal title scheme, alternative to the PS1 way

# reference: http://linuxcommando.blogspot.ca/2009/05/open-file-from-command-line-using-its.html
# alternatives: gnome-open , kde-open
alias open=xdg-open

#alias diarytoday='touch ~/diary/`date +%Y-%m-%d`.md && vim -p `ls ~/diary/2019-* | sort | tail -n 5` +tablast && rm `find ~/diary -empty -regex ".*/2019-[0-9][0-9]-[0-9][0-9].md"`'
diarytoday() {
  local diarydir=$(echo ~/diary)
  local day=$(date +%Y-%m-%d)
  local month=$(date +%Y-%m)
  local markdown='.md'
  local day_file=$(echo $diarydir/$day$markdown)
  local month_file=$(echo $diarydir/$month$markdown)
  local last_four=$(ls $diarydir/$(date +%Y)-[0-9][0-9]-[0-9][0-9].md | sort | tail -n 4)
  local last_five=$(ls $diarydir/$(date +%Y)-[0-9][0-9]-[0-9][0-9].md | sort | tail -n 5)
  if [ -e $day_file ]; then
    vim -p $month_file $last_five +tablast
  else
    vim -p $month_file $last_four $day_file +tablast
  fi
  find $diarydir -empty -regex ".*/20[0-9][0-9]-[0-9][0-9]-[0-9][0-9].md" -exec rm {} \;
  # [[ ! -e $day_file ]] && last_file=$day_file
  # vim -p $month_file `ls ~/diary/2019-* | sort | tail -n 5` $last_file +tablast && find ~/diary -empty -regex ".*/2019-[0-9][0-9]-[0-9][0-9].md" -exec rm {} \;
}

alias webservethis="python -m SimpleHTTPServer 8000 >> ~/webservelog.txt"
alias makesshwork="eval \"\$(ssh-agent -s)\"; ssh-add ~/.ssh/*rsa"   # TODO: how do ssh-agent and ssh-add work?

alias diffy="diff -y"

# I'm really unsure about this one.  I hate pyc files in my projects, tho.
export PYTHONDONTWRITEBYTECODE=i_hate_pyc_files   # if set to not-empty string, disables .pyc and .pyo


export NVM_DIR="/home/jholman/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# alias scheme='rlwrap scheme'
alias trashfire='echo "need sudo to start as suitable user, feel free to read the alias" && sudo -u mongodb mongod --config /etc/mongodb.conf'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Let's experiment with using https://github.com/nvbn/thefuck
which fuck > /dev/null
if [ $? -eq 0 ]
then
  eval $(thefuck --alias)
fi



# Hey, maybe I have some bashrc-like stuff that is machine-specific.
if [ -f ~/.local_bashrc ]; then
    . ~/.local_bashrc
fi
