# Objective 7: Printer Exploitation
****Location: Jack's Office, Frost Tower, 16<sup>th</sup> Floor, https://printer.kringlecastle.com/**  
**Troll: Ruby Cyster**  
**Hints provided by Ruby Cyster after completion of [Shellcode Primer](https://github.com/joergschwarzwaelder/hhc2021/blob/master/Objective-6/README.md)**

This objective is to get hold of the name of the latest file (type .xlsx) printed. This can be found on the printer in `/var/spool/printer.log`.
The web frontend of the printer has the capability to download the firmware currently being used and to upload a new signed firmware package.
As an additional hint it was disclosed, that files dropped to `/app/lib/public/incoming` will be accessible in the web frontend in https://printer.kringlecastle.com/incoming

The high level approach to solve the objective is

 - retrieve the current firmware
 - add an own payload to the firmware whilst keeping the firmware package signature intact
 - upload the new firmware
 - retrieve file `/var/spool/printer.log`

### Analysis of the original firmware package downloaded from the printer
The firmware package is a JSON file consisting out of these data fields:
- firmware: Base64 encoded ZIP file (containing the ELF binary "firmware.bin")
- signature: hash of {secret||ZIP file}
- secret_length: length of the secret prefixed to the ZIP file to create the hash
- algorithm: hash algorithm, SHA256 is used

### Hash Length Extension Attack
The [Hash Length Extension Attack](https://blog.skullsecurity.org/2012/everything-you-need-to-know-about-hash-length-extension-attacks) is based on the fact, that if you have "data" and the hash of {secret||data}, you are able to create a new valid hash for {secret||data||payload}, even without knowing the secret.
This is possible by replicating the state of the hashing algorithm, which is buried in the hash value.
If the state of the hash algorithm is recovered, it can be used to continue it's calculation over the payload data.
This leads to a new hash, but this is still valid.

### Build new firmware package
It is now possible to choose between two different payloads ([copy file to incoming folder](https://github.com/joergschwarzwaelder/hhc2021/blob/master/Objective-7/payload-copy), [reverse shell](https://github.com/joergschwarzwaelder/hhc2021/blob/master/Objective-7/payload-reverse-shell)) and then to create a ZIP file containing the payload with filename "firmware.bin".
Next the hash_extender tool is used to append the new ZIP file to the old one whilst creating a new valid hash (hash_extender -d {firmware in as hex string} --data-format=hex -s {signature as hex string} -l {secret length, here: 16} -a {payload as hex string} --append-format=hex).
Upon extraction, the first, original, ZIP file is ignored and only the appended ZIP containing the custom payload will be extracted and executed.
All of this is then packed into a JSON file (the new firmware data is provided by the tool as a hex string, it has to be converted into a base64 encoded binary), which will be accepted by the firmware update process.

### Upload firmware package
Next the new firmware JSON file is uploaded to the printer using the web interface and as part of this process the payload is executed.

### Retrieve data
Finally the file /var/spool/printer.log can be retrieved using the method predetermined by the payload.

### Content of printer.log
```
Documents queued for printing
=============================

Biggering.pdf
Size Chart from https://clothing.north.pole/shop/items/TheBigMansCoat.pdf
LowEarthOrbitFreqUsage.txt
Best Winter Songs Ever List.doc
Win People and Influence Friends.pdf
Q4 Game Floor Earnings.xlsx
Fwd: Fwd: [EXTERNAL] Re: Fwd: [EXTERNAL] LOLLLL!!!.eml
Troll_Pay_Chart.xlsx
```
So the solution is **Troll_Pay_Chart.xlsx**

---
### Bonus: Automation
The full process was automated in the [exploit-bot.pl](https://github.com/joergschwarzwaelder/hhc2021/blob/master/Objective-7/exploit-bot.pl).
It expects hash_extender to be available in the current directory and just consumes an option "-p" to specify the payload file.
The script downloads the current firmware package, adds the payload, creates the new hash and uploads the new firmware package to the printer.

**Achievement: Hash extension of ELF or firmware**
