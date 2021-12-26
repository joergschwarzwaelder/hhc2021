# IPv6 Sandbox
**Location: Talks Lobby, Santa's Castle, 2<sup>nd</sup> floor**  
**Elf: Jewel Loggins**

The objective is hosted on a Cranberry Pi terminal.
A Password has to be ontained which is on a different, unknown server.

In order to check which other devices are on the network a ping to the link local all hosts IPv6 multicast address ff02::1 is performed:
```
ping6 ff02::1
```
Apart from out own IPv6 address fe80::42:c0ff:fea8:a003, two others were found reachable:

 - fe80::42:c0ff:fea8:a002 (seems to be the host in scope)
 - fe80::42:ecff:fefe:94a1 (seems to be a router)
 
 An nmap scan on the host
 ```
 nmap -6 -n fe80::42:c0ff:fea8:a002%eth0
 ```
  shows two open ports, 80 and 9000.
A curl against port 80
```
curl --interface eth0 -6 http://[fe80::42:c0ff:fea8:a002]:80
```
 returns, that we should use the other open port.
A curl against port 9000
```
curl --interface eth0 -6 http://[fe80::42:c0ff:fea8:a002]:9000
```
returns the activation phrase **PieceOnEarth**.

**Achievement: IPv6 Sandbox**  
The Elf provides hints for [objective 5](https://github.com/joergschwarzwaelder/hhc2021/tree/master/Objective-5):  
**Hint: Ducky Script**  
**Hint: Duck Encoder**  
**Hint: Ducky RE with Mallard**  
**Hint: Mitre ATT&CK<sup>TM</sup> and Ducky**
