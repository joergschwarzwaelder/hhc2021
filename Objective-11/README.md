<h1 id="objective-11-customer-complaint-analysis">Objective 11: Customer Complaint Analysis</h1>
<p><strong>Location: FrostFest Talks Lobby (Frost Tower, 2nd floor)</strong><br>
<strong>Elf: Pat Tronizer</strong></p>
<p>This objective is about getting familiar with Wireshark.</p>
<p>A <a href="https://downloads.jackfrosttower.com/2021/jackfrosttower-network.zip">network capture file</a> is provided.<br>
According to Jack Frosts policy, all devices on the network must have the <a href="https://datatracker.ietf.org/doc/html/rfc3514">evil bit</a> in the IP header set.<br>
The objective is to find the traffic originated by humans and then to find, which trolls are complaning about this human.</p>
<p>To find the human, the Wireshark filter</p>
<pre><code>!(ip.flags.rb == 1)
</code></pre>
<p>was used. It was found that the human is in room 1024.</p>
<p>Filtering for this room</p>
<pre><code>urlencoded-form.value contains "room 1024"
</code></pre>
<p>reveals that Yaqh, Flud and Hagg are complaining about the lady in this room.<br>
Sorting the names results in the solution <strong>Flud Hagg Yaqh</strong></p>

