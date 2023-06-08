#!/bin/bash

INTERVAL_M=15
INTERVAL_S=$((INTERVAL_M * 60))
TIMEOUT=1800000 # 1800s

last_time=$(date +%s)
deviation=0

while true
do
    sleep 10s
    now=$(date +%s)
    elapsed=$((now - last_time - deviation))
    if [ "$elapsed" -ge "$INTERVAL_S" ]; then
        deviation=$((elapsed - INTERVAL_S))
        dunstify \
            -t ${TIMEOUT} \
            "你该休息了" \
            "<b>距上次休息已过去${INTERVAL_M}分钟，请适度休息。</b>" \
            -i /usr/share/icons/Adwaita/32x32/categories/emoji-people-symbolic.symbolic.png
        last_time="$now"
        echo "rest scheduled at $(date), deviation: ${deviation}"
    fi
done

