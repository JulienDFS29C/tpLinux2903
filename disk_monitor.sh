#!/bin/bash

percentage=$(df / --output=pcent | sed -n '2p' | tr -d ' %');

message=$(echo "Disk space almost full : $percentage% used");

echo $percentage;

if [ "$percentage" -gt 10 ]; then

	slackUrl=$(echo "https://hooks.slack.com/services/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")
	curl -X POST -H "Content-Type: application/json" --data '{"text":"Disk space almost full'$percentage'% used"}' --location $slackUrl
fi
