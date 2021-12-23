<h1 id="hoho-...-no">HoHo … No</h1>
<p><strong>Location: Santa’s Office, Santa’s Castle, 3<sup>rd</sup> Floor</strong><br>
<strong>Elf: Eve Snowshoes</strong></p>
<p>This game is about getting familiar with fain2ban.</p>
<p>The following files were prepared to filter the malicious requests from the log file and to trigger the addition to the naughty list.</p>
<p>/etc/fail2ban/action.d/hohono.conf:</p>
<pre><code>[Definition]
actionban = /root/naughtylist add &lt;ip&gt;
actionunban = /root/naughtylist del &lt;ip&gt;
</code></pre>
<p>/etc/fail2ban/jail.d/hohono.conf:</p>
<pre><code>[hohono]
usedns = no
enabled=true
maxretry=10
findtime=1h
bantime=1h
logpath=/var/log/hohono.log
action = hohono
filter= hohono
</code></pre>
<p>/etc/fail2ban/filter.d/hohono.conf:</p>
<pre><code>[Definition]
failregex = Login from &lt;HOST&gt; rejected due to unknown user name$\b
            Invalid heartbeat '[a-z]*' from &lt;HOST&gt;$\b
            Failed login from &lt;HOST&gt; for .*$\b
            &lt;HOST&gt; sent a malformed request$\b
ignoreregex= &lt;HOST&gt;: Request completed successfully$\b
             Valid heartbeat from &lt;HOST&gt;$\b
             Login from &lt;HOST&gt; successful$\b
</code></pre>
<p>After creatiion of these files, the fail2ban service is restarted and the processing of the log file triggered:</p>
<pre><code>root@930652a879a9:/etc/fail2ban# service fail2ban restart
root@930652a879a9:/etc/fail2ban# /root/naughtylist refresh
</code></pre>
<p><strong>Achievement "HoHo … No"</strong><br>
<strong>Objective 8 unlocked</strong><br>
The Elf provides hints for <a href="https://github.com/joergschwarzwaelder/hhc2021/tree/master/Objective-8">objective 8</a>:<br>
<strong>Hint: Kerberoast and AD Abuse Talk</strong><br>
<strong>Hint: Kerberoasting and Hashcat Syntax</strong><br>
<strong>Hint: Finding Domain Controllers</strong><br>
<strong>Hint: Hashcat Mangling Rules</strong><br>
<strong>Hint: CeWL for Wordlist Creation</strong><br>
<strong>Hint: Stored Credentials</strong><br>
<strong>Hint: Active Directory Interrogation</strong></p>

