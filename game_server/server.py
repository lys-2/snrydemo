#!/bin/python
"""
game server

env variables:
    SERVER_IP - set to "0.0.0.0" or it'll be on localhost
    SERVER_PORT - server port (default "1215")
    SERVER_AFK_TIME - time before afk player kick (int seconds, default 60)
    SERVER_RECV_SIZE - max size of packet (int kbytes, default 10)

send to server by udp json with player name and some data
server will send data of all players

to delete player from server list send "delete" key with any data
if player is not active he'll be also deleted

EXAMPLE:
    send to server:
    {
        "name": "fwewfewfe",
        "x": 1,
        "y": 2,
    }

    get from server:
    {
        "fwewfewfe": {
            "x": 1,
            "y": 2,
        }
    }

    send to server:
    {
        "name": "fwewfewfe",
        "delete": 1
    }

    get from server:
    {}

"""

import socket
import json
from os import getenv
from _thread import start_new_thread
from time import sleep


UDP_IP = getenv("SERVER_IP", "127.0.0.1")
UDP_PORT = int(getenv("SERVER_PORT", "1215"))
AFK_TIME = int(getenv("SERVER_AFK_TIME", "60"))
RECV_SIZE = int(getenv("SERVER_RECV_SIZE", "10"))

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind((UDP_IP, UDP_PORT))

players = {}

def delete_afk_players():
    while 1:
        sleep(1)
        for name in list(players.keys()):
            try:
                players[name][("system", "time_before_kick")] -= 1
                if players[name][("system", "time_before_kick")] <= 0:
                    players.pop(name)
                    print(f"[AFK KICKED] {name}")
            except Exception as e:
                print(f"[DELETE AFK ERROR {type(e)}] {e=} {name=}")



if __name__ == "__main__":
    start_new_thread(delete_afk_players, ())

    while 1:
        rawdata, addr = sock.recvfrom(1024*RECV_SIZE)
        try:
            data = json.loads(rawdata.decode("ascii"))
            print(f"[{addr}] {data}")

            if "delete" in data:
                players.pop(data["name"])
            else:
                name = data.pop("name")
                players[name] = data
                players[name][("system", "time_before_kick")] = AFK_TIME

            sock.sendto(json.dumps(players, skipkeys=True).encode("ascii"), addr)
            print(f"[RESPONSE] {json.dumps(players, skipkeys=True)}")
        except Exception as e:
            print(f"[ERROR {type(e)}] {addr=} {e=} {rawdata=}")
            sock.sendto(f'{{"error": {e}}}'.encode("ascii"), addr)
