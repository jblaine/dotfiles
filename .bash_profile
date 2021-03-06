# The following stops shellcheck from trying to read and check files
# referenced via '.' or 'source'
# shellcheck source=/dev/null

if [ -e /etc/r701-shell-init/system.profile ]; then
  source /etc/r701-shell-init/system.profile
  AT_WORK=1
else
  AT_WORK=0
fi

if [ $AT_WORK -eq 1 ]; then
  source "$HOME/.bash_profile_work"
fi

if [ -e "$HOME/.bashrc" ]; then
	source "$HOME/.bashrc"
fi

# Disable bash processing of Ctrl-S (flow control)
if which stty > /dev/null 2>&1; then
  stty -ixon
fi
# Append to existing history file instead of overwriting
shopt -s histappend
# Make multi-line commands fit on one line
shopt -s cmdhist
# Allow many entries
export HISTSIZE=2000
# Ignore duplicate commands (ignoredups) and also ignore
# any commands that begin with whitespace.
export HISTCONTROL='ignoredups:ignorespace'
# Ignore common crap
export HISTIGNORE='ls:bg:fg:history'

export LC_ALL=en_US.UTF-8

# Ignore files with the suffixes .o and ~ when doing file-completion
FIGNORE=".o:~"

alias ls='ls -CF --group-directories-first'
alias more='less'
unset GREP_OPTIONS

# If we have tput, our TERM allows more than 8 colors, and ls supports
# the '--colors' option, use coloring for stuff.
if which tput > /dev/null 2>&1; then
  if [[ $(tput -T"$TERM" colors) -ge 8 ]]; then
    # Here we use 'ls' as the global decider. If ls supports
    # colors, we assume the rest of the other commands in the
    # environment support colors as well.
    if ls --color /tmp > /dev/null 2>&1; then
      # Color support! Good for all but cygwinx, I've found.
      if [ "$TERM"x != "cygwinx" ]; then
        alias more='less -r'
        alias grep='\grep --color=auto'
        alias ls='ls --color=auto -CF'
        export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:'
      fi
    fi
  fi
fi

if [ "$(uname -s)" = "Linux" ]; then
  export PS_FORMAT='user,pid,ppid,pcpu,pmem,args'
  alias ps='ps -ewwH'
fi

export LESS='--long-prompt'

MANPATH=${MANPATH}:~/man
PS1='\W:\h> '

export EDITOR="vi"
export VISUAL="vi"
# If we find vim, use it.
for bindir in /usr/bin /bin
do
  if [ -f $bindir/vim ]; then
    alias vi=vim
    export EDITOR="vim"
    export VISUAL="vim"
    export VIMHOME="$HOME/.vim"
    break
  fi
done

# Git aliases
alias gst='git status'
alias gc='git commit'
alias gca='git commit -a'
alias gb='git branch'
alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gg='git log --oneline --abbrev-commit --decorate --all --graph --date=relative  --pretty=format:"%C(bold blue)%h%Cred%d %Creset%s"'

# Chef aliases
alias knife='echo use k!; \knife'
alias k='\knife'

if [ -f "$HOME/liquidprompt/liquidprompt" ]; then
  if ! [ -d /mtcnas ]; then
    if ! uname -s | grep MING > /dev/null 2>&1; then
      source "$HOME/liquidprompt/liquidprompt"
    fi
  fi
else
  echo "Not a file: ~/liquidprompt/liquidprompt"
fi

vault_singleitem () {
  if [ "$1"x = "x" ]; then
    echo "Usage: vault_singleitem <key>"
    echo ""
    echo "Spits out a JSON key (argument) and value (from stdin) for"
    echo "use in chef-vault"
    echo ""
    echo "Hit Ctrl-D twice (for some reason) to end your input if typing"
    echo "or pasting to stdin."
    echo ""
    echo "Example: vault_singleitem deploy-key < deploy.pem > deploy.json"
    echo ""
  else
    ruby -rjson -e "puts JSON.generate({\"$1\" => STDIN.read()})"
  fi
}

if [ -e ~/.git_bash_functions ]; then
  source ~/.git_bash_functions
fi

if [ -e "$HOME/.dir_colors" ]; then
  unset LS_COLORS
  eval "$(dircolors "$HOME/.dir_colors")"
fi

# Yes, we do this again.
if [ $AT_WORK -eq 1 ]; then
  source "$HOME/.bash_profile_work"
fi
