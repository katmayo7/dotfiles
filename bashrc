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

# Update displaylink adapter
function update_adapter() {(
    # Make errors fatal
    set -e

    # Location of DisplayLink RPM repo.
    # Currently: https://github.com/displaylink-rpm/displaylink-rpm
    local user="displaylink-rpm"
    local repo="$user"
    local api_base="https://api.github.com"

    # Source /etc/os-release for distribution and version
    . /etc/os-release
    if [ "x$NAME" != "xFedora" ]; then
        echo "Unknown distribution: $NAME -- only Fedora is supported."
        return 1
    fi

    echo "Removing old displaylink package..."
    sudo dnf remove displaylink -y || true

    echo "Downloading new displaylink package..."
    rm /tmp/displaylink.rpm /tmp/displaylink.json -rf
    wget -O /tmp/displaylink.json "$api_base/repos/$user/$repo/releases"
    grep -F 'browser_download_url' /tmp/displaylink.json |
        grep -F "fedora-$VERSION_ID" |
        grep -F "x86_64" |
        head -n 1 |
        grep -o 'http[s].*\.rpm' |
        wget -i - -O /tmp/displaylink.rpm

    echo "Installing new displaylink package..."
    sudo dnf install /tmp/displaylink.rpm -y
)}
