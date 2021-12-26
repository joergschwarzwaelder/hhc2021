# Grepping for Gold
**Location: North Pole**
**Troll: Greasy GopherGuts**

This objective is based on a Cranberry Pi terminal and is a training for the `grep` command.
The `grep` command should be used to filter the output of an NMAP run to answer several questions.

- What port does 34.76.1.22 have open?
```
elf@b84f0d151e02:~$ grep 34.76.1.22 bigscan.gnmap
Host: 34.76.1.22 () Ports: 62078/open/tcp//iphone-sync/// Ignored State: closed (999)
```
**62078**
- What port does 34.77.207.226 have open?
```
elf@b84f0d151e02:~$ grep 34.77.207.226 bigscan.gnmap
Host: 34.77.207.226 () Ports: 8080/open/tcp//http-proxy/// Ignored State: filtered (999)
```
**8080**

- How many hosts appear "Up" in the scan?
```
elf@b84f0d151e02:~$ grep Up bigscan.gnmap | wc -l
26054
```
**26054**
- How many hosts have a web port open? (Let's just use TCP ports 80, 443, and 8080)
```
elf@b84f0d151e02:~$ egrep -e '(80|443|8080)/open' bigscan.gnmap | grep Host: | wc -l
14372
```
**14372**
- How many hosts with status Up have no (detected) open TCP ports?
```
elf@b84f0d151e02:~$ awk -F' ' '{ print $2 }' bigscan.gnmap | grep -v Nmap | sort | uniq -c | sort -n | grep " 1 " | wc -l
402
```
**402**
- What's the greatest number of TCP ports any one host has open?
```
elf@b84f0d151e02:~$ awk -F "," '{print NF}' bigscan.gnmap | sort -n | tail -1
12
```
**12**

**Achievement: Grepping for Gold**
The Troll provides hints for [objective 3](https://github.com/joergschwarzwaelder/hhc2021/tree/master/Objective-3):
**Hint: Linux Wi-Fi Commands**
**Hint: Web Browsing with cURL**
**Hint: Adding Data to cURL requests**
