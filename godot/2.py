from twisted.protocols.ftp import FTPFactory, FTPRealm
from twisted.cred.portal import Portal
from twisted.cred.checkers import AllowAnonymousAccess, FilePasswordDB
from twisted.internet import reactor
import py7zr
import os
import socket

import time

if os.path.exists('r/web/7z/web.7z'):
    os.remove('r/web/7z/web.7z')
if os.path.exists('r//web/7z/ln.7z'):
    print(1)
    os.remove('r//web/7z/ln.7z')

os.system('.\godot -v --no-window --export "HTML5" r\web\snd.html')
os.system('.\godot -v --no-window --export "Linux/X11" r\ln\snrydemo')

with py7zr.SevenZipFile('r/web/7z/web.7z', 'w') as archive:
    archive.writeall('r/web', '')
print(12)


with py7zr.SevenZipFile('r/web/7z/ln.7z', 'w') as archive:
    archive.writeall('r/ln', '')
print(22)

sock = socket.socket(socket.AF_INET, # Internet
                     socket.SOCK_DGRAM) # UDP
sock.sendto(b"1", ("noeight.net", 1234))

# os.system('taskkill -f /IM "python3.9.exe"')