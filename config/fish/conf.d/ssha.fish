#!/bin/fish
#
# Start ssh-agent in the background
#

if ! test -d ~/.ssh
    echo "creating ~/.ssh..."
    mkdir ~/.ssh
    chmod 700 ~/.ssh
    echo "OK"
end

if ! test -f ~/.ssh/environment
    echo "creating ~/.ssh/environment..."
    touch ~/.ssh/environment
    chmod 600 ~/.ssh/environment
    echo "OK"
end

if test -z "$SSH_ENV"
    set -xg SSH_ENV $HOME/.ssh/environment
end

if not __ssh_agent_is_started
    __ssh_agent_start
end
