if [ -f /afs/rcf/admin/init/system.profile ]; then
    . /afs/rcf/admin/init/system.profile
    AT_WORK=1
else
    AT_WORK=0
fi

if [ -f ${HOME}/.bashrc ]; then
	. ${HOME}/.bashrc
fi

HISTSIZE=200

# Ignore files with the suffixes .o and ~ when doing file-completion
# FIGNORE='.o'
FIGNORE=''

alias ls='ls -CF'

OS=`uname -s`
if [ $OS = "SunOS" ]; then
    export TERM=sun-color
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
