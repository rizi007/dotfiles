#!/bin/bash

USERNAME=$USER
DOTFILES_ROOT=$(pwd)
GIT_ALIASES_PATH=$DOTFILES_ROOT/git/aliases
SYS_ALIASES_PATH=$DOTFILES_ROOT/sys/aliases
BASH_PROFILE_PATH='/Users/'$USERNAME'/.bash_profile'

if [ -e $GIT_ALIASES_PATH -a ! -x $GIT_ALIASES_PATH ]; then
  chmod +x $GIT_ALIASES_PATH
fi

if [ -e $SYS_ALIASES_PATH -a ! -x $SYS_ALIASES_PATH ]; then
  chmod +x $SYS_ALIASES_PATH
fi

if [ -e $BASH_PROFILE_PATH -a -e $GIT_ALIASES_PATH -a -e $SYS_ALIASES_PATH ]; then
  CMD='cat '$BASH_PROFILE_PATH' | grep -i "source '$GIT_ALIASES_PATH'" | wc -l'
  op=`eval "$CMD"`
  if [ $op -eq 0 ];then
    echo 'source '$GIT_ALIASES_PATH >> $BASH_PROFILE_PATH
  fi
  CMD='cat '$BASH_PROFILE_PATH' | grep -i "source '$SYS_ALIASES_PATH'" | wc -l'
  op=`eval "$CMD"`
  if [ $op -eq 0 ]; then
    echo 'source '$SYS_ALIASES_PATH >> $BASH_PROFILE_PATH
  fi
  source $BASH_PROFILE_PATH
else
  echo 'One or more files not found. PWD => $DOTFILES_ROOT.'
  echo ' The "install.sh" has to be run from inside the "dotfiles" folder.'
fi
