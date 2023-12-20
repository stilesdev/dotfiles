#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

for script in ~/.config/shell/*.sh; do
    . "$script"
done
