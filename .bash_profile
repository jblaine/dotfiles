if [ -f /afs/rcf/admin/init/system.profile ]; then
  . /afs/rcf/admin/init/system.profile
  AT_WORK=1
else
  AT_WORK=0
fi

if [ $AT_WORK -eq 1 ]; then
  . ${HOME}/.bash_profile_work
fi

if [ -f ${HOME}/.bashrc ]; then
	. ${HOME}/.bashrc
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

# Ignore files with the suffixes .o and ~ when doing file-completion
FIGNORE=".o:~"

alias ls='ls -CF'
alias more='less'
unset GREP_OPTIONS

# If we have tput, our TERM allows more than 8 colors, and ls supports
# the '--colors' option, use coloring for stuff.
if which tput > /dev/null 2>&1 && [[ $(tput -T$TERM colors) -ge 8 ]]; then
  # Here we use 'ls' as the global decider. If ls supports
  # colors, we assume the rest of the other commands in the
  # environment support colors as well.
  if ls --color /tmp > /dev/null 2>&1; then
    # Color support! Good for all but cygwinx, I've found.
    if [ "$TERM"x != "cygwinx" ]; then
      alias more='less -r'
      export GREP_OPTIONS='--color=auto'
      alias ls='ls --color=auto -CF'
      export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:'
    fi
  fi
fi

if [ `uname -s` = "Linux" ]; then
  export PS_FORMAT='user,pid,ppid,pcpu,pmem,args'
  alias ps='ps -ewwH'
fi

export LESS='--long-prompt'

MANPATH=${MANPATH}:${HOME}/man
PS1="\W:\h> "

EDITOR=vi
VISUAL=vi
# If we find vim, use it.
for bindir in /usr/bin /bin /usr/rcf/bin
do
  if [ -x $bindir/vim ]; then
    alias vi=vim
    EDITOR=vim
    VISUAL=vim
    VIMHOME=$HOME/.vim
    break
  fi
done

# Git aliases
alias gst='git status'
alias gca='git commit -a'
alias gc='git commit'
alias gb='git branch'
alias ga='git add'

if [ -f "$HOME/liquidprompt/liquidprompt" ]; then
  # Work Solaris boxes with homedir in AFS are too slow
  # for all of this background prompt-tweaking hoo-ha
  if [ `uname -s` != "SunOS" ]; then
    source "$HOME/liquidprompt/liquidprompt"
  fi
fi

# Yes, we do this again.
if [ $AT_WORK -eq 1 ]; then
  . ${HOME}/.bash_profile_work
fi
