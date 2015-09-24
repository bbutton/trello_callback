#!/bin/bash

if [ $# -ne 2 ]; then
    echo "usage: find_board_id.sh <trello dev id> <trello token>" >&2
    exit 1
fi

TRELLO_DEV_ID=$1
TRELLO_TOKEN=$2

curl -s -XGET https://api.trello.com/1/members/me/boards?fields=name\&key=${TRELLO_DEV_ID}\&token=${TRELLO_TOKEN} | jq -c '.[] | {board_id: .id, name: .name}'

exit $?

