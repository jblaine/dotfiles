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
HISTSIZE=2000
# Ignore duplicate commands (ignoredups) and also ignore
# any commands that begin with whitespace.
HISTCONTROL='ignoredups:ignorespace'
# Ignore common crap
HISTIGNORE='ls:bg:fg:history'

# Ignore files with the suffixes .o and ~ when doing file-completion
FIGNORE=".o:~"

alias ls='ls -CF'

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

export GREP_OPTIONS='--color=auto'

if [ $AT_WORK -eq 1 ]; then
    . ${HOME}/.bash_profile_work
fi
