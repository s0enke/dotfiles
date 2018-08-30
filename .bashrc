# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

unset color_prompt force_color_prompt

__git_uncommitted_changes() {
  output=$(git status 2>/dev/null)
  if echo $output | grep 'use "git reset HEAD <file>..." to unstage' -q ; then
    # Staged changes (turquoise) You may use git commit now.
    echo -e '\e[36m'
  elif echo $output | grep "working directory clean" -q ; then
    # No staged or unstaged changes (green)
    echo -e '\e[32m'
  elif echo $output | grep 'use "git add" and/or "git commit -a"' -q ; then
    # Unstaged changes (red). Use git add.
    echo -e '\e[31m'
  elif echo $output | grep 'use "git add" to track' -q ; then
    # Yet unknown files (orange). Use git add.
    echo -e '\e[33m'
  fi
}

PS1='${debian_chroot:+($debian_chroot)}\u\[$(__git_uncommitted_changes)\]♥\[\e[0m\]\h${STAGING_SYSTEM:+[$STAGING_SYSTEM]}:\w$(__git_ps1 " (%s)")\$ '

__no_git_magic_ps1() {
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
}

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

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

alias l='ls -al'
alias ..='cd ..'
alias ...='cd ../..'

export GITHUB_USER=s0enke

# go
export GOPATH=$HOME/projects/go
PATH=$PATH:~/projects/go/bin
PATH=$PATH:/usr/local/go/bin

# docker shortcuts
alias jessie='docker run -i -t debian:jessie /bin/bash'

# cmdline completition
complete -C '/usr/local/bin/aws_completer' aws
