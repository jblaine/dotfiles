if [ -f /afs/rcf/admin/init/system.bashrc ]; then
  . /afs/rcf/admin/init/system.bashrc
  AT_WORK=1
else
  AT_WORK=0
fi

#  Items intended for INTERACTIVE shells should be placed in
#  $HOME/.bash_profile instead of this file.

if [ -d /opt/csw ]; then
  PATH=/opt/csw/bin:$PATH
fi

PATH=${HOME}/bin:${PATH}

if [ $AT_WORK -eq 1 ]; then
  PATH=${HOME}/mylocal/bin:${PATH}:/afs/rcf/admin/local/bin:/afs/rcf/admin/bin:/afs/rcf/admin/utils/vect/bin:/afs/rcf/admin/utils/ats/bin
fi

if [ -d /afs/rcf/user/jblaine/.gem/ruby/2.1.0/bin ]; then
  PATH=/afs/rcf/user/jblaine/.gem/ruby/2.1.0/bin:$PATH
elif [ -d /opt/chefdk ]; then
  PATH=/opt/chefdk/bin:$PATH
fi

if [ $OSTYPE = "linux-gnu" ]; then
  PATH=$PATH:/usr/X11R6/bin
fi

CVSUMASK=002
CVS_RSH=ssh

GIT_SSL_NO_VERIFY=true

HISTCONTROL="ignoreboth"
HISTSIZE=5000
HISTFILESIZE=10000
HISTTIMEFORMAT='%m-%d-%y %T '

