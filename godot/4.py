import os, socket
a  = os.popen('wsl hostname -I').readlines()
print(a)
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.sendto(b"0", (a, 1234))