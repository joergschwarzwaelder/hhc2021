# Elf Code Python
**Location: Dining Room, Santa's Castle, Ground Floor**  
**Elf: Ribb Bonbowford**

This game is about getting familiar with Python.

### Level 1:
```python
import elf, munchkins, levers, lollipops, yeeters, pits
elf.moveLeft(10)
elf.moveUp(10)
```
### Level 2:
```python
import elf, munchkins, levers, lollipops, yeeters, pits
elf.moveLeft(10)
elf.moveUp(2)
elf.moveRight(3)
elf.moveUp(2)
elf.moveLeft(3)
elf.moveUp(6)
```
### Level 3:
```python
import elf, munchkins, levers, lollipops, yeeters, pits
lever0 = levers.get(0)
lollipop0 = lollipops.get(0)
elf.moveTo(lever0.position)
lever0.pull(lever0.data()+2)
elf.moveTo(lollipop0.position)
elf.moveUp(10)
```
### Level 4:
```python
import elf, munchkins, levers, lollipops, yeeters, pits
# Complete the code below:
lever0, lever1, lever2, lever3, lever4 = levers.get()
# Move onto lever4
elf.moveLeft(2)
# This lever wants a str object:
lever4.pull("A String")
# Need more code below:
elf.moveTo(lever3.position)
lever3.pull(True)
elf.moveTo(lever2.position)
lever2.pull(0)
elf.moveTo(lever1.position)
lever1.pull(["Kingle","Con"])
elf.moveTo(lever0.position)
lever0.pull({"country" : "France", "worldcups" : 2})
elf.moveUp(2)
```
## Level 5:
```python
import elf, munchkins, levers, lollipops, yeeters, pits
lever0, lever1, lever2, lever3, lever4 = levers.get()
elf.moveTo(lever4.position)
lever4.pull(lever4.data()+" concatenate")
elf.moveTo(lever3.position)
lever3.pull(not lever3.data())
elf.moveTo(lever2.position)
lever2.pull(lever2.data()+1)
elf.moveTo(lever1.position)
list=lever1.data()
list.append(1)
lever1.pull(list)
elf.moveTo(lever0.position)
dict=lever0.data()
dict['strkey']='strvalue'
lever0.pull(dict)
elf.moveUp(2)
```
### Level 6:
```python
import elf, munchkins, levers, lollipops, yeeters, pits
lever = levers.get(0)
elf.moveTo(lever.position)
data = lever.data()
if type(data) == bool:
    data = not data
elif type(data) == int:
    data = data * 2 
elif type(data) == str:
    data = data+data
elif type(data) == list:
    data = map(lambda number : number+1,data)
elif type(data) == dict:
    data['a']=data['a']+1
lever.pull(data)
elf.moveUp(2)
```
### Level 7:
```python
import elf, munchkins, levers, lollipops, yeeters, pits
for num in range(3):
    elf.moveLeft(3)
    elf.moveUp(11)
    elf.moveLeft(2)
    elf.moveDown(11)
```    
### Level 8:
```python
import elf, munchkins, levers, lollipops, yeeters, pits
all_lollipops = lollipops.get()
for lollipop in all_lollipops:
    elf.moveTo(lollipop.position)
lever=levers.get(0)
elf.moveTo(lever.position)
list=lever.data()
list.insert(0,"munchkins rule")
lever.pull(list)
elf.moveDown(3)
elf.moveLeft(6)
elf.moveUp(2)
```
**Achievement: Elf Code Python**

### Bonus Levels
### Level 9:
```python
import elf, munchkins, levers, lollipops, yeeters, pits

def func_to_pass_to_munchkin(list_of_lists):
    return sum(list(map(lambda l : sum([i for i in l if isinstance(i,int)]),list_of_lists)))

munchkins.get(0).answer(func_to_pass_to_munchkin)
all_levers = levers.get()
moves = [elf.moveDown, elf.moveLeft, elf.moveUp, elf.moveRight] * 2
for i, move in enumerate(moves):
    move(i+1)
    if i<len(all_levers):
      all_levers[i].pull(i)
elf.moveUp(2)
elf.moveLeft(4)
elf.moveUp(1)
```
### Level 10:
```python
import elf, munchkins, levers, lollipops, yeeters, pits
import time

muns = munchkins.get()
lols = lollipops.get()[::-1]
for index, mun in enumerate(muns):
  while abs(mun.position["x"]-elf.position["x"])<6:
    time.sleep(0.1)
  elf.moveTo(lols[index].position)
elf.moveLeft(6)
elf.moveUp(2)
```
**Achievement: Elf Code Python Bonus Levels!**

The Elf provides hints for [objective 12](https://github.com/joergschwarzwaelder/hhc2021/tree/master/Objective-12), which are not captured in Avatar's hint section:  
**[Node.js express-session](https://www.npmjs.com/package/express-session)**  
**[mysqljs](https://github.com/mysqljs/mysql)**
