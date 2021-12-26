# Logic Munchers
**Location: North Pole**  
**Elf: Noel Boetie**

This challenge is about evaluating logic expressions and selecting all expressions which are "True".
This is absolutely doable manually, but if you are lazy you are able to cheat.  
Open the browser's developer tools and switch to the console.
Then select `game` in the context picker:  
![Context Picker](https://github.com/joergschwarzwaelder/hhc2021/blob/master/Additional/Context-Picker.png)  
Then execute this script, which enables you to automatically solve each level in Elves' speed:
```javascript
function Sleep(mils){
  return new Promise(resolve => setTimeout(resolve,mils));
}

var mystage=-1;
for(;;){
  while(stage==mystage)await Sleep(1000);
  mystage=stage;
  for(var x=0;x<=5;x++)
    for(var y=0;y<=4;y++){
	  if (challenges[x][y][1]) {
        document.getElementById(x + ',' + y).innerHTML = "";
        challenges[x][y] = [[],[]];
		score += 100;
		document.getElementById("score").innerHTML = "<h2>" + score + "</h2>";
	  }
    }
  checkWin();
}
```
Automation in action: https://joergschwarzwaelder.github.io/Holiday%20Hack%20Challenge%202021%20-%20Logic%20-%20Munchers.webm

**Achievement: Logic Munchers**  
The Elf provides hints for [objective 4](https://github.com/joergschwarzwaelder/hhc2021/tree/master/Objective-4):  
**Hint: Parameter Tampering**  
**Hint: Intercepting Proxies**
