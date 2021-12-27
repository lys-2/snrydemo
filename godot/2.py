
import py7zr
import os
import socket

import time

def ar(data):
    with py7zr.SevenZipFile(w, 'w') as archive:
        archive.writeall('../godot/r/web', '')
    print(12)
    sock.sendto(data, ("noeight.net", 1234))

UDP_IP = "0.0.0.0"
UDP_PORT = 1234

ready = True

sock = socket.socket(socket.AF_INET, # Internet
                     socket.SOCK_DGRAM) # UDP
sock.bind((UDP_IP, UDP_PORT))

while True:

    data, addr = sock.recvfrom(111) 
    print(f'Got {data} from {addr}')

    w = '../godot/r/7z/web.7z'
    l = '../godot/r/7z/ln.7z'

    if os.path.exists(w):
        os.remove(w)
    if os.path.exists(l):
        print(1)
        os.remove(l)


    # os.system('cp -Force -Recurse C:\snrydemo\godot\*')
    if data == b'1\n' or data == b'int\x00,i\x00\x00\x00\x00\x00@':
        os.system('./godot --path ../godot -v --no-window --export-pack "HTML5 2" r/web/snd.pck')
        ar(b'1')
    if data == b'0\n':
        os.system('./godot --path ../godot -v --no-window --export "HTML5" r/web/snd.html')
        ar(b'0')

    # os.system('./godot --path /mnt/c/snrydemo/godot -v --no-window --export "Linux/X11" r/ln/snrydemo')

    # with py7zr.SevenZipFile(l, 'w') as archive:
    #     archive.writeall('/mnt/c/snrydemo/godot/r/ln', '')
    # print(22)



    # os.system('taskkill -f /IM "python3.9.exe"')
