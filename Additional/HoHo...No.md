# HoHo ... No
**Location: Santa's Office, Santa's Castle, 3<sup>rd</sup> Floor**
**Elf: Eve Snowshoes**

This game is about getting familiar with Fail2Ban.

The following files were prepared to filter the malicious requests from the log file and to trigger the addition to the naughty list.

/etc/fail2ban/action.d/hohono.conf:
```
[Definition]
actionban = /root/naughtylist add <ip>
actionunban = /root/naughtylist del <ip>
```
/etc/fail2ban/jail.d/hohono.conf:
```
[hohono]
usedns = no
enabled=true
maxretry=10
findtime=1h
bantime=1h
logpath=/var/log/hohono.log
action = hohono
filter= hohono
```
/etc/fail2ban/filter.d/hohono.conf:
```
[Definition]
failregex = Login from <HOST> rejected due to unknown user name$\b
            Invalid heartbeat '[a-z]*' from <HOST>$\b
            Failed login from <HOST> for .*$\b
            <HOST> sent a malformed request$\b
ignoreregex= <HOST>: Request completed successfully$\b
             Valid heartbeat from <HOST>$\b
             Login from <HOST> successful$\b
```

After creation of these files, the Fail2Ban service is restarted and the processing of the log file triggered:
```
root@930652a879a9:/etc/fail2ban# service fail2ban restart
root@930652a879a9:/etc/fail2ban# /root/naughtylist refresh
```
**Achievement: HoHo ... No**
**Objective 8 unlocked**
The Elf provides hints for [objective 8](https://github.com/joergschwarzwaelder/hhc2021/tree/master/Objective-8):
**Hint: Kerberoast and AD Abuse Talk**
**Hint: Kerberoasting and Hashcat Syntax**
**Hint: Finding Domain Controllers**
**Hint: Hashcat Mangling Rules**
**Hint: CeWL for Wordlist Creation**
**Hint: Stored Credentials**
**Hint: Active Directory Interrogation**
