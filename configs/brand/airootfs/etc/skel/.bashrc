#
# ~/.bashrc
#

# If not running interactively, don't do anything
if [[ ! $- =~ i ]]; then
  return
fi

if [[ -z $TMUX ]]; then
  exec tmux
elif [[ -z $RANGER_LEVEL ]]; then
  exec ranger
fi
