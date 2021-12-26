# Objective 4: Slot Machine Investigation
**Location: https://slots.jackfrosttower.com/**
**Hints provided by Noel Boethie after completion of [Logic Munchers](https://github.com/joergschwarzwaelder/hhc2021/blob/master/Additional/Logic%20Munchers.md)**

The objective is to analyze Jack Frosts slot machines and to try to get more than 1000 coins. When reaching this, the server will respond with the solution in the data.response field.

Using the Firefox' developers tools it is easily possible to analyze the HTTP requests performed when playing the game.
It was found (using the "Edit and resend" feature), that for
```
betamount=10
numline=-20
cpl=1
```
the coins are increased by 200 (seems to be the negated product of all three values) for every single game played, so that 1000 coins can be obtained without any issues.
When reaching 1000+ coins, the server response contains in the data.response field:
**I'm going to have some bouncer trolls bounce you right out of this casino!**

**Achievement: Slot Machine Scrutiny**
