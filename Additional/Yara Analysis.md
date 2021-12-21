<h1 id="yara-analysis">Yara Analysis</h1>
<p><strong>Location: Entry, Santa’s Castle, Ground Floor</strong><br>
<strong>Elf: Fitzy Shortstack</strong></p>
<p>This challenge is based on a Cranberry Pi terminal and is about modifying a binary to escape an existing YARA ruleset.</p>
<pre><code>snowball2@1f8d0eab2566:~$ ./the_critical_elf_app
yara_rule_135 ./the_critical_elf_app
</code></pre>
<p>Rule 135 defines <code>candycane</code> to be a malicious string.<br>
So the executable was hex dumped and the string changed to <code>candycone</code>.</p>
<p>Running the modified binary results in Yara rule 1056 matching:</p>
<pre><code>snowball2@1f8d0eab2566:~$ ./the
yara_rule_1056 ./the
</code></pre>
<p>This rule defines <code>rogram!!</code> as malicious.<br>
We replace the first <code>!</code> in the binary with a blank.</p>
<p>In next run Yara rule 1732 matches:</p>
<pre><code>snowball2@1f8d0eab2566:~$ ./the
yara_rule_1732 ./the
</code></pre>
<p>This rule defines executables having at position #1 <code>0x02464c45</code> resp. <code>45 4c 46 02</code> (which is the case for all ELF binaries) <strong>and</strong> a file size less than 50KB <strong>and</strong> matching several defined strings to be malicious.<br>
To circumvent the match on the file size, 60000 null bytes were appended to the executable:</p>
<pre><code>snowball2@08cc17df3e9c:~$ dd if=/dev/zero of=zeroes bs=1 count=60000
60000+0 records in
60000+0 records out
60000 bytes (60 kB, 59 KiB) copied, 0.225491 s, 266 kB/s
snowball2@08cc17df3e9c:~$ cat zeroes &gt;&gt; the
snowball2@08cc17df3e9c:~$ ./the
Machine Running..
Toy Levels: Very Merry, Terry
Naughty/Nice Blockchain Assessment: Untampered
Candy Sweetness Gauge: Exceedingly Sugarlicious
Elf Jolliness Quotient: 4a6f6c6c7920456e6f7567682c204f76657274696d6520417070726f766564
</code></pre>
<p><strong>Achievement: Yara Analysis</strong><br>
The Elf provides hints for <a href="https://github.com/joergschwarzwaelder/hhc2021/tree/master/Objective-9">objective 9</a>:<br>
<strong>Hint: GitHub monitoring in Splunk</strong><br>
<strong>Hint: Sysmon Monitoring in Splunk</strong><br>
<strong>Hint: Malicious NetCat??</strong></p>

