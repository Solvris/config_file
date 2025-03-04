# ~/.bashrc: Configuration file for non-login interactive shells

# Exit if not an interactive shell
case $- in
    *i*) ;; # Continue if interactive shell
      *) return;; # Exit if not interactive
esac

# History settings
HISTCONTROL=ignoreboth       # Ignore duplicate commands and commands starting with space
shopt -s histappend          # Append history to the file instead of overwriting
HISTSIZE=1000                # Number of commands to keep in memory
HISTFILESIZE=2000            # Maximum number of commands to store in the history file

# Check window size after each command and update LINES and COLUMNS
shopt -s checkwinsize

# Enable color support for tools like `ls`
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'  # Colorized output for `ls`
    alias ll='ls -alF'          # Long listing format with file type indicators
    alias la='ls -A'            # List all files including hidden ones (except . and ..)
    alias l='ls -CF'            # Compact listing with file type indicators
fi

# Define other useful aliases
alias vi='vim'                # Use `vim` instead of `vi`
alias cls='clear'             # Clear the terminal screen
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
                                # Notification for long-running commands

# Set the prompt
if [ "$EUID" -eq 0 ]
  then PS1="\[\033[0m\]\[\033[35m\][\A]\[\033[31m\]\u\[\033[33m\]@\h\[\033[34m\]:\w \[\033[31m\]# \[\033[0m\]"
else
  # Regular user settings
  PS1="\[\033[0m\]\[\033[35m\][\A]\[\033[32m\]\u\[\033[33m\]@\h\[\033[34m\]:\w \[\033[32m\]\\\$ \[\033[0m\]"
fi

# Set terminal title if supported
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
esac

# Load custom aliases file if it exists
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable programmable completion features
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi
