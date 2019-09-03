if [ -f /etc/r701-shell-init/system.bashrc ]; then
  . /etc/r701-shell-init/system.bashrc
  AT_WORK=1
else
  AT_WORK=0
fi

#  Items intended for INTERACTIVE shells should be placed in
#  ${HOME}/.bash_profile instead of this file.

PATH=${HOME}/bin:${PATH}

if [ $AT_WORK -eq 1 ]; then
  PATH=${HOME}/mylocal/bin:${PATH}
fi

if [ -d "${HOME}/.gem/ruby/2.1.0/bin" ]; then
  PATH=${HOME}/.gem/ruby/2.1.0/bin:${PATH}
elif [ -d /opt/chefdk ]; then
  PATH=/opt/chefdk/bin:${PATH}
fi

if [ "$OSTYPE" = "linux-gnu" ]; then
  PATH=${HOME}/arches/amd64_linux26/bin:${PATH}
fi

HISTCONTROL="ignoreboth"
HISTSIZE=5000
HISTFILESIZE=10000
HISTTIMEFORMAT='%m-%d-%y %T '
