#!/bin/bash

# run server
export SERVER_IP="127.0.0.1"
export SERVER_PORT="1215"
export SERVER_AFK_TIME="1"
./server.py &
SERVER_PID=$!
sleep 1

# send jsons
echo '{"name": "test1", "x": 1, "y": 2}' >/dev/udp/127.0.0.1/1215
echo '{"name": "test2", "x": 12, "y": 22}' >/dev/udp/127.0.0.1/1215
echo '{"name": "test1", "delete": 1, "x": 12, "y": 22}' >/dev/udp/127.0.0.1/1215
sleep 2
echo '{"name": "test3", "x": 1, "y": 2}' >/dev/udp/127.0.0.1/1215

# kill server
sleep 1
kill $SERVER_PID
