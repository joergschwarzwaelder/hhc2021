<h1 id="logic-munchers">Logic Munchers</h1>
<p><strong>Location: North Pole</strong><br>
<strong>Elf: Noel Boetie</strong></p>
<p>This challenge is about evaluating logic expressions and selecting all expressions which are “True”.<br>
This is absolutely doable manually, but if you are lazy you are able to cheat.<br>
Open the browser’s developer tools and switch to the console.<br>
Then select <code>game</code> in the context picker:<br>
<img src="https://github.com/joergschwarzwaelder/hhc2021/blob/master/Additional/Context-Picker.png" alt="Context Picker"><br>
Then execute this script which enable you to automatically solve each level in Elves’ speed:</p>
<pre><code>function Sleep(mils){
  return new Promise(resolve =&gt; setTimeout(resolve,mils));
}

for(;;){
  while(challenges[0][0][0]=="")await Sleep(1000);
  for(var x=0;x&lt;=5;x++)
    for(var y=0;y&lt;=4;y++){
      challenges[x][y][0]="";
      challenges[x][y][1]=false;
      checkWin();
    }
}
</code></pre>
<p><strong>Achievement: Logic Munchers</strong><br>
The Elf provides hints for <a href="https://github.com/joergschwarzwaelder/hhc2021/tree/master/Objective-4">objective 4</a>:<br>
<strong>Hint: Parameter Tampering</strong><br>
<strong>Hint: Intercepting Proxies</strong></p>

