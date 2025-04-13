#!/bin/bash

STATUS=$(mullvad status | grep -o 'Connected\|Disconnected')

if [ "$STATUS" = "Connected" ]; then
    echo "  "
else
    echo "  "
fi
