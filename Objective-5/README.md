<h1 id="objective-5-strange-usb-device">Objective 5: Strange USB Device</h1>
<p>**Location: <strong>UNPreparedness Room, Santa’s Castle, 2<sup>nd</sup> Floor</strong><br>
<strong>Elf: Morcel Nougat</strong><br>
<strong>Hints provided by Jewel Loggins after completion of <a href="https://github.com/joergschwarzwaelder/hhc2021/blob/master/Additional/IPv6%20Sandbox.md">IPv6 Sandbox</a></strong></p>
<p>This objective is to analyze data on a USB Rubber Ducky device in /mnt/usbdevice on a Cranberry Pi. The script <a href="http://mallard.py">mallard.py</a> is provided in the home directory.</p>
<p>Executing <code>./mallard.py --file /mnt/USBDEVICE/inject.bin</code> reveals a (reversed) base64 encoded shell script.<br>
Executing exactly this command without sending it to the bash shell shows, that the script adds an SSH key to the user’s authorized_keys file. In the comment field we have presumably the owner, <strong>ickymcgoop</strong>@trollfun.jackfrosttower.com.</p>
<p><img src="https://github.com/joergschwarzwaelder/hhc2021/blob/master/Objective-5/ssh-key.png" alt="SSH key information"><br>
<strong>Achievement: Strange USB Device</strong></p>

