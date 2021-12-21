<h1 id="grepping-for-gold">Grepping for Gold</h1>
<p><strong>Location: North Pole</strong><br>
<strong>Troll: Greasy GopherGuts</strong></p>
<p>This objective is based on a Cranberry Pi terminal and is a training for the <code>grep</code> command.<br>
The <code>grep</code> command should be used to filter the output of an NMAP run to answer several questions.</p>
<ul>
<li>What port does 34.76.1.22 have open?</li>
</ul>
<pre><code>elf@b84f0d151e02:~$ grep 34.76.1.22 bigscan.gnmap
Host: 34.76.1.22 () Ports: 62078/open/tcp//iphone-sync/// Ignored State: closed (999)
</code></pre>
<p><strong>62078</strong></p>
<ul>
<li>What port does 34.77.207.226 have open?</li>
</ul>
<pre><code>elf@b84f0d151e02:~$ grep 34.77.207.226 bigscan.gnmap
Host: 34.77.207.226 () Ports: 8080/open/tcp//http-proxy/// Ignored State: filtered (999)
</code></pre>
<p><strong>8080</strong></p>
<ul>
<li>How many hosts appear “Up” in the scan?</li>
</ul>
<pre><code>elf@b84f0d151e02:~$ grep Up bigscan.gnmap | wc -l
26054
</code></pre>
<p><strong>26054</strong></p>
<ul>
<li>How many hosts have a web port open? (Let’s just use TCP ports 80, 443, and 8080)</li>
</ul>
<pre><code>elf@b84f0d151e02:~$ egrep -e '(80|443|8080)/open' bigscan.gnmap | grep Host: | wc -l
14372
</code></pre>
<p><strong>14372</strong></p>
<ul>
<li>How many hosts with status Up have no (detected) open TCP ports?</li>
</ul>
<pre><code>elf@b84f0d151e02:~$ awk -F' ' '{ print $2 }' bigscan.gnmap | grep -v Nmap | sort | uniq -c | sort -n | grep " 1 " | wc -l
402
</code></pre>
<p><strong>402</strong></p>
<ul>
<li>What’s the greatest number of TCP ports any one host has open?</li>
</ul>
<pre><code>elf@b84f0d151e02:~$ awk -F "," '{print NF}' bigscan.gnmap | sort -n | tail -1
12
</code></pre>
<p><strong>12</strong></p>
<p><strong>Achievement: "Grepping for Gold"</strong><br>
The Troll provides hints for <a href="https://github.com/joergschwarzwaelder/hhc2021/tree/master/Objective-3">objective 3</a>:<br>
<strong>Hint: Linux Wi-Fi Commands</strong><br>
<strong>Hint: Web Browsing with cURL</strong><br>
<strong>Hint: Adding Data to cURL requests</strong></p>

