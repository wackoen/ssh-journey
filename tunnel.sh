#!/bin/bash
PORT=10006
SERVER="105.35.58.108"
REMOTEIP="127.0.0.1"
REMOTEPORT=22
OPTION="-R" # -R = Remote, -L = Local

###
# @function tunnel
###
function tunnel_ssh {
    if [ "`ps -eaf | grep nNgf | grep $PORT | grep -v grep`" ] ; then
        echo "Local Port tunnel to $REMOTE is up"
    else
        echo "Local Port tunnel ${REMOTE} NOT alive ... Restarting ..."
        /usr/bin/ssh -nNgf $1@$2 $3 $4:$5:$6
        logger -p daemon.notice "SSH Forward Local Port ${REMOTE} NOT Alive ... Restarting ..."
        sleep 1
    fi
}

##
# Request User
#
case "$1" in
    '-u')
        USER=$2
        if [ -z "$USER" ]; then
             echo -e "Username Required.\n $(basename $0) [username]"
        else
            tunnel_ssh $USER $SERVER $OPTION $PORT $REMOTEIP $REMOTEPORT
        fi
    ;;
    *)
        echo "Usage: $(basename $0) [username]"
    ;;
esac
