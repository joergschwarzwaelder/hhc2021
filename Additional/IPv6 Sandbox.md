<h1 id="ipv6-sandbox">IPv6 Sandbox</h1>
<p><strong>Location: Talks Lobby, Santa’s Castle, 2<sup>nd</sup> floor</strong><br>
<strong>Elf: Jewel Loggins</strong></p>
<p>The objective is hosted on a Cranberry Pi terminal.<br>
A Password has to be ontained which is on a different, unknown server.</p>
<p>In order to check which other devices are on the network a ping to the link local all hosts IPv6 multicast address ff02::1 is performed:</p>
<pre><code>ping6 ff02::1
</code></pre>
<p>Apart from out own IPv6 address fe80::42:c0ff:fea8:a003, two others were found reachable:</p>
<ul>
<li>fe80::42:c0ff:fea8:a002 (seems to be the host in scope)</li>
<li>fe80::42:ecff:fefe:94a1 (seems to be a router)</li>
</ul>
<p>An nmap scan on the host</p>
<pre><code>nmap -6 -n fe80::42:c0ff:fea8:a002%eth0
</code></pre>
<p>shows two open ports, 80 and 9000.<br>
A curl against port 80</p>
<pre><code>curl --interface eth0 -6 http://[fe80::42:c0ff:fea8:a002]:80
</code></pre>
<p>returns, that we should use the other open port.<br>
A curl against port 9000</p>
<pre><code>curl --interface eth0 -6 http://[fe80::42:c0ff:fea8:a002]:9000
</code></pre>
<p>returns the activation phrase <strong>PieceOnEarth</strong>.</p>
<p><strong>Achievement "IPv6 Sandbox"</strong><br>
The Elf provides hints for <a href="https://github.com/joergschwarzwaelder/hhc2021/tree/master/Objective-5">objective 5</a>:<br>
<strong>Hint: Ducky Script</strong><br>
<strong>Hint: Duck Encoder</strong><br>
<strong>Hint: Ducky RE with Mallard</strong><br>
<strong>Hint: Mitre ATT&amp;CK<sup>TM</sup> and Ducky</strong></p>

