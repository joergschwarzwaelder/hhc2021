<h1 id="objective-7-printer-exploitation">Objective 7: Printer Exploitation</h1>
<p><strong>Location: ?? <a href="https://printer.kringlecastle.com/">https://printer.kringlecastle.com/</a></strong><br>
<strong>Elf: Ruby Cyster</strong></p>
<p>This objective is to get hold of the name of the latest file (type .xlsx) printed. This can be found on the printer in /var/spool/printer.log.<br>
The web frontend of the printer has the capability to download the firmware currently being used and to upload a new signed firmware package.<br>
As an additional hint it was disclosed, that files dropped to /app/lib/public/incoming will be accessible in the web frontend in <a href="https://printer.kringlecastle.com/incoming">https://printer.kringlecastle.com/incoming</a></p>
<p>The high level approach to solve the objective is</p>
<ul>
<li>retrieve the current firmware</li>
<li>add an own payload to the firmware whilst keeping the firmware package signature intact</li>
<li>upload the new firmware</li>
<li>retrieve file /var/spool/printer.log</li>
</ul>
<h2 id="analysis-of-the-original-firmware-package-downloaded-from-the-printer">Analysis of the original firmware package downloaded from the printer</h2>
<p>The firmware package is a JSON file consisting out of these data fields:</p>
<ul>
<li>firmware: Base64 encoded ZIP file (containing the ELF binary “firmware.bin”)</li>
<li>signature: hash of secret||ZIP file</li>
<li>secret_length: length of the secret prefixed to the ZIP file to create the hash</li>
<li>algorithm: hash algorithm, SHA256 is used</li>
</ul>
<h2 id="hash-length-extension-attack">Hash Length Extension Attack</h2>
<p><strong>blablabla???</strong><br>
<a href="https://blog.skullsecurity.org/2012/everything-you-need-to-know-about-hash-length-extension-attacks">Explanation of the Hash Length Extension Attack</a></p>
<h2 id="build-new-firmware-package">Build new firmware package</h2>
<p>It is now possible to choose between two different payloads (<a href="https://github.com/joergschwarzwaelder/hhc2021/blob/master/Objective-7/payload-copy">copy file to incoming folder</a>, <a href="https://github.com/joergschwarzwaelder/hhc2021/blob/master/Objective-7/payload-reverse-shell">reverse shell</a>) and then to create a ZIP file containing the payload with filename “firmware.bin”.<br>
Next the hash_extender tool is used to append the new ZIP file to the old one whilst creating a new valid signature.<br>
Upon extraction the first, original, ZIP file is ignored and only the ZIP containing out custom payload will be extracted and executed.<br>
All of this is then packed into a JSON file, which has the correct signature and will be accepted by the firmware update process.</p>
<h2 id="upload-firmware-package">Upload firmware package</h2>
<p>Next the new firmware JSON file is uploaded to the printer using the web interface.</p>
<h2 id="retrieve-data">Retrieve data</h2>
<p>Finally the file /var/spool/printer.log can be retrieved using the method predetermined by the payload.</p>
<h2 id="automation">Automation</h2>
<p>The full process was automated in the <a href="https://github.com/joergschwarzwaelder/hhc2021/blob/master/Objective-7/exploit-bot.pl">exploit-bot.pl</a>.<br>
It expects hash_extender to be available in the current directory and just consumes an option “-p” to specify the payload file.<br>
The script downloads the current firmware package, adds the payload, creates the new signature and upload the new firmware package to the printer.</p>
<h3 id="content-of-printer.log">Content of printer.log</h3>
<pre><code>Documents queued for printing
=============================

Biggering.pdf
Size Chart from https://clothing.north.pole/shop/items/TheBigMansCoat.pdf
LowEarthOrbitFreqUsage.txt
Best Winter Songs Ever List.doc
Win People and Influence Friends.pdf
Q4 Game Floor Earnings.xlsx
Fwd: Fwd: [EXTERNAL] Re: Fwd: [EXTERNAL] LOLLLL!!!.eml
Troll_Pay_Chart.xlsx
</code></pre>
<p>So the solution is <strong>Troll_Pay_Chart.xlsx</strong></p>

