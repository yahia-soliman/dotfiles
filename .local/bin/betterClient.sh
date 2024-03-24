#!/usr/bin/env bash
#usage: betterClient <METHOD> <url> <data>
data="'${3}'"
curl -X "$1" "$2" -H "Content-type: application/json" -d "$data" && echo

