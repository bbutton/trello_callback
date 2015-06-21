#!/usr/bin/env bash

if [ $# -ne 3 ]; then
    echo "usage: delete_webhook.sh <trello_dev_id> <trello_token> <webhook_id>" >&2
    echo "where" >&2
    echo -e "\ttrello_dev_id - User\'s application/developer key" >&2
    echo -e "\ttrello_token - User\'s secret token" >&2
    echo -e "\twebhook_id - ID of webhook found from list_existing_webhooks.sh" >&2
    exit 1
fi

TRELLO_DEV_ID=$1
TRELLO_TOKEN=$2
WEBHOOK_ID=$3

curl -X DELETE https://trello.com/1/webhooks/${WEBHOOK_ID}?key=${TRELLO_DEV_ID}\&token=${TRELLO_TOKEN}

