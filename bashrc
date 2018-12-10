# .bashrc

for i in /etc/profile.d/*.sh; do
        source $i
done

if [ "$TILIX_ID" ] || [ "$VTE_VERSION" ]; then
        source /etc/profile.d/vte.sh
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# Enable powerline
if [ ! -f "$HOME/.no_powerline" ] && [ -f "$(which powerline-daemon)" ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bash/powerline.sh
fi

activate_env () {
        source '/home/kmayo/python-virtual-environments/'$1'/bin/activate'
}

export -f activate_env

alias cshared='cd /run/media/kmayo/Shared'

alias p_envs='cd ~/python-virtual-environments/'

# added by Anaconda3 installer
export PATH="/home/kmayo/anaconda3/bin:$PATH"
