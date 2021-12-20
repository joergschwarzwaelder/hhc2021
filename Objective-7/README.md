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
<li>firmware: Base64 encoded ZIP file</li>
<li>signature: hash of secret||ZIP file</li>
<li>secret_length: length of the secret prefixed to the ZIP file to create the hash</li>
<li>algorithm: hash algorithm, SHA256 is used</li>
</ul>
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
<p>So the solution is <strong>Troll_Pay_Chart.xlsx</strong>.</p>

