<h1 id="objective-5-strange-usb-device">Objective 5: Strange USB Device</h1>
<p>**Location: <strong>UNPreparedness Room (Santa’s Castle, Floor 2)</strong><br>
<strong>Elf: Morcel Nougat</strong></p>
<p>This objective is to analyze data on a USB Rubber Ducky device in /mnt/usbdevice on a Cranberry Pi. The script <a href="http://mallard.py">mallard.py</a> is provided in the home directory.</p>
<p>Executing <strong>./mallard.py --file /mnt/USBDEVICE/inject.bin</strong> reveals a (reversed) base64 encoded shell script.<br>
Executing exactly this command without sending it to the bash shell shows, that the script adds an SSH key to the user’s authorized_keys file. In the comment field we have presumably the owner, <strong>ickymcgoop</strong>@trollfun.jackfrosttower.com.</p>
<p><img src="https://github.com/joergschwarzwaelder/hhc2021/blob/master/Objective-5/ssh-key.png" alt="SSH key information"></p>

