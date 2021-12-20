<h1 id="objective-4-slot-machine-investigation">Objective 4: Slot Machine Investigation</h1>
<p><strong>Location: <a href="https://slots.jackfrosttower.com/">https://slots.jackfrosttower.com/</a></strong><br>
<strong>Elf: Noel Boetie</strong></p>
<p>This objective analyze Jack Frosts slot machines and to try to get more than 1000 coins. When reaching this, the server will respond with the solution in the data.response field.</p>
<p>Using the Firefox’ developers tools it is easily possible to analyze the HTTP requests performed when playing the game.<br>
It was found (using the “Edit and resend” feature), that for</p>
<pre><code>betamount=10
numline=-20
cpl=1
</code></pre>
<p>the coins are increased by 200 (seems to be the negated product of all three values) for every single game played, so that 1000 coins can be obtained without any issues.<br>
When reaching 1000+ coins, the server response contains in the data.response field:<br>
<strong>I’m going to have some bouncer trolls bounce you right out of this casino!</strong></p>

