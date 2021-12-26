
# Objective 3: Thaw Frost Tower's Entrance
**Location: Castle Approach**

**Elf: Grimy McTrollkins**

**Hints provided by Gready GopherGuts after completion of [Grepping for Gold](https://github.com/joergschwarzwaelder/hhc2021/blob/master/Additional/Grepping%20for%20Gold.md)**

This objective is to thaw the frozen entrance to the Frost Tower.
To accomplish this, the Wifi Dongle received from Jingle Ringford has to be used.

It is possible connect to the Wifi of the Frost Tower and to consume the API of the building management system to increase the temperature:
```
elf@a8b522b14ea5:~$ iwlist scan
wlan0     Scan completed :
          Cell 01 - Address: 02:4A:46:68:69:21
                    Frequency:5.2 GHz (Channel 40)
                    Quality=48/70 Signal level=-62 dBm
                    Encryption key:off
                    Bit Rates:400 Mb/s
                    ESSID:"FROST-Nidus-Setup"
 
elf@a8b522b14ea5:~$ iwconfig wlan0 essid "FROST-Nidus-Setup"
** New network connection to Nidus Thermostat detected! Visit http://nidus-setup:8080/ to complete setup
(The setup is compatible with the 'curl' utility)

elf@a8b522b14ea5:~$ curl -XPOST -H 'Content-Type: application/json' --data-binary '{"temperature":25}' http://nidus-setup:8080/api/cooler
{
  "temperature": 25.71,
  "humidity": 92.41,
  "wind": 1.3,
  "windchill": 27.87,
  "WARNING": "ICE MELT DETECTED!"
}
```

**Achievement: Thaw Frost Tower's Entrance**
