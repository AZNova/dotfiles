# .bashrc

alias vim=/usr/local/bin/vim


# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

#
# git branch display in prompt
#
function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2>/dev/null) || return
    echo "("${ref#refs/heads/}")"
}

RESET="\[\033[0;0m\]"
BRIGHT="\[\033[0;1m\]"
DIM="\[\033[0;2m\]"
UNDERSCORE="\[\033[0;4m\]"
BLINK="\[\033[0;5m\]"
REVERSE="\[\033[0;7m\]"
HIDDEN="\[\033[0;8m\]"

#ForegroundColours
F_BLACK="\[\033[0;30m\]"
F_RED="\[\033[0;31m\]"
F_GREEN="\[\033[0;32m\]"
F_YELLOW="\[\033[0;33m\]"
F_BLUE="\[\033[0;34m\]"
F_MAGENTA="\[\033[0;35m\]"
F_CYAN="\[\033[0;36m\]"
F_WHITE="\[\033[0;37m\]"

#BackgroundColours
B_BLACK="\[\033[0;40m\]"
B_RED="\[\033[0;41m\]"
B_GREEN="\[\033[0;42m\]"
B_YELLOW="\[\033[0;43m\]"
B_BLUE="\[\033[0;44m\]"
B_MAGENTA="\[\033[0;45m\]"
B_CYAN="\[\033[0;46m\]"
B_WHITE="\[\033[0;47m\]"



PS1="$F_RED[\u@\h \W]$F_YELLOW \$(parse_git_branch)$F_WHITE\$ "
# PS1="$RED\$(hostname -s) \w$YELLOW \$(parse_git_branch)$GREEN\$ "
# PS1="[\u@\h \W]\\$ "


source .git-completion.bash


#
# ssh-agent for storing my ssh key passphrase for github so I don't have to
# type it in over andover again for every commit
#

# Note: ~/.ssh/environment should not be used, as it
#       already has a different purpose in SSH.

env=~/.ssh/agent.env

# Note: Don't bother checking SSH_AGENT_PID. It's not used
#       by SSH itself, and it might even be incorrect
#       (for example, when using agent-forwarding over SSH).

agent_is_running() {
    if [ "$SSH_AUTH_SOCK" ]; then
        # ssh-add returns:
        #   0 = agent running, has keys
        #   1 = agent running, no keys
        #   2 = agent not running
        ssh-add -l >/dev/null 2>&1 || [ $? -eq 1 ]
    else
        false
    fi
}

agent_has_keys() {
    ssh-add -l >/dev/null 2>&1
}

agent_load_env() {
    . "$env" >/dev/null
}

agent_start() {
    (umask 077; ssh-agent >"$env")
    . "$env" >/dev/null
}

if ! agent_is_running; then
    agent_load_env
fi

if ! agent_is_running; then
    agent_start
    ssh-add
elif ! agent_has_keys; then
    ssh-add
fi

unset env
