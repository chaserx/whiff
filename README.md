# whiff

_catch a whiff of this._

an interface to sniffing MAC addresses on the local network through [arp-scan](http://www.nta-monitor.com/wiki/index.php/Arp-scan_Documentation).

**installing arp-scan**

mac os x:

1. brew update
1. brew install arp-scan

linux:

1. sudo apt-get update
1. sudo apt-get intall arp-scan

**running arp-scan**

on mac os x, try:

`sudo arp-scan -l -s 10.0.1.1 -I en1 -q`

where 10.0.1.1 is the IP address of your router, and en1 is the name of your active network interface.

on linux, try:

`sudo arp-scan -l -s 10.0.1.1 -I wlan0 -q`

where 10.0.1.1 is the IP address of your router, and wlan0 is the name of your active network interface.

either of these should return something similar to the following:

    Interface: en1, datalink type: EN10MB (Ethernet)
    Starting arp-scan 1.8 with 256 hosts (http://www.nta-monitor.com/tools/arp-scan/)
    10.0.1.29   00:13:21:c1:28:9a
    10.0.1.4    20:c9:d0:b5:61:21
    10.0.1.3    8c:3a:e3:98:81:2d
    10.0.1.8    94:94:26:95:09:f0
    10.0.1.2    00:00:48:64:11:ef
    10.0.1.200  b8:27:eb:13:65:e7

    537 packets received by filter, 0 packets dropped by kernel
    Ending arp-scan 1.8: 256 hosts scanned in 1.171 seconds (218.62 hosts/sec). 6 responded

