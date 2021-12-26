# Objective 5: Strange USB Device
**Location: **UNPreparedness Room, Santa's Castle, 2<sup>nd</sup> Floor**
**Elf: Morcel Nougat**
**Hints provided by Jewel Loggins after completion of [IPv6 Sandbox](https://github.com/joergschwarzwaelder/hhc2021/blob/master/Additional/IPv6%20Sandbox.md)**


This objective is to analyze data on a USB Rubber Ducky device in /mnt/usbdevice on a Cranberry Pi. The script mallard.py is provided in the home directory.

Executing `./mallard.py --file /mnt/USBDEVICE/inject.bin` reveals a (reversed) base64 encoded shell script.
Executing exactly this command without sending it to the bash shell shows, that the script adds an SSH key to the user's authorized_keys file. In the comment field we have presumably the owner, **ickymcgoop**@trollfun.jackfrosttower.com.

![SSH key information](https://github.com/joergschwarzwaelder/hhc2021/blob/master/Objective-5/ssh-key.png)
**Achievement: Strange USB Device**
