#!/usr/bin/env bash

if [ $# -ne 2 ]; then
    echo "usage: list_existing_webhooks.sh <trello dev id> <trello token>" >&2
    exit 1
fi

TRELLO_DEV_ID=$1
TRELLO_TOKEN=$2

curl -s -XGET https://api.trello.com/1/tokens/${TRELLO_TOKEN}/webhooks?key=${TRELLO_DEV_ID}\&token=${TRELLO_TOKEN} | jq -c '.[] | {id: .id, desc: .description, board_id: .idModel}'

exit $?
