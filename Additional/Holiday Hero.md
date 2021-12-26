# Holiday Hero
**Location: NetWars, Santa's Castle, Roof**  
**Elf: Chimney Scissorsticks**

This game can be completed in two different ways, Two player mode or single player mode.

### Two Player Mode
The game score depends on the capability of both players. It is doable, but you need to concentrate on the game; the same applies of course to the other player. Furthermore, some browsers tend to have some lag in this game.

### Single Player Mode
In the single player mode the other player is the computer.
In order to activate the single player mode, the following has to be done:
- Activate the single player mode in the cookie: If not done yet, set the single player mode variable in the game cookie to true (there should be a browser extensions available for the browser used) and restart the game. By sending this value to the server upon game start, the server knows that it is expected to act as one of the two players.
![setting the game cookie for single player mode](https://github.com/joergschwarzwaelder/hhc2021/blob/master/Additional/holiday-hero-cookie.png)
- Activate the single player mode in the browser. To perform this, take these steps:
  - click "Create Room"
  - open the developer tools, Console
  - select the game context c_{integer}
  - `single_player_mode=true` 
    ![setting single player mode to true](https://github.com/joergschwarzwaelder/hhc2021/blob/master/Additional/holiday-hero-variable.png)
  - the game will state, that the computer joined as second player
  - The computer will act as a perfect player, so the game result does only depend on your own capabilities.

**Achievement: Holiday Hero**  
The Elf provides hints for [objective 6](https://github.com/joergschwarzwaelder/hhc2021/tree/master/Objective-6):  
**Hint: Shellcode Primer Primer**  
**Hint: Debugging Shellcode**  
**Hint: Register Stomping**
