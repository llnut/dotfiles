#!/bin/bash

CARD_ID=$(aplay -l | tail -n 3 | head -n 1 | awk -F ':' '{print $1}' | awk -F ' ' '{print $NF}')
amixer -c $CARD_ID scontrols

