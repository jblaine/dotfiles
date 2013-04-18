if [ -f /afs/rcf/admin/init/system.profile ]; then
  . /afs/rcf/admin/init/system.profile
  AT_WORK=1
else
  AT_WORK=0
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

if [ "$TERM"x = "cygwinx" ]; then
    alias more=less
fi

ls --color /tmp > /dev/null 2>&1
if [ $? -eq 0 ]; then
    alias ls='ls --color=auto -CF'
    if [ "$TERM"x != "cygwinx" ]; then
        alias ls='ls --color=auto -CF'
        export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:'
        # This probably is allowed as well then
        export GREP_OPTIONS='--color=auto'
    fi
else
    alias ls='ls -CF'
fi

if [ `uname -s` = "Linux" ]; then
  export PS_FORMAT='user,pid,ppid,pcpu,pmem,args'
  alias ps='ps -ewwH'
fi

EDITOR=vi
VISUAL=vi
# If we find vim, use it.
for vdir in /usr/bin /bin /usr/rcf/bin
do
  if [ -x $vdir/vim ]; then
    alias vi=vim
    EDITOR=vim
    VISUAL=vim
    VIMHOME=$HOME/.vim
    break
  fi
done

MANPATH=${MANPATH}:${HOME}/man

PS1="\W:\h> "

if [ $AT_WORK -eq 1 ]; then
  . ${HOME}/.bash_profile_work
fi
