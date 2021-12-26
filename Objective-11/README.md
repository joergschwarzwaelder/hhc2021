# Objective 11: Customer Complaint Analysis
**Location: FrostFest Talks Lobby, Frost Tower, 2<sup>nd</sup> Floor**
**Troll: Pat Tronizer**
**Hints provided by Tinsel Upatree after completion of [Strace, Ltrace, Retrace](https://github.com/joergschwarzwaelder/hhc2021/blob/master/Additional/Strace,%20Ltrace,%20Retrace.md)**

This objective is about getting familiar with Wireshark.

A [network capture file](https://downloads.jackfrosttower.com/2021/jackfrosttower-network.zip) is provided.
According to Jack Frosts policy, all devices on the network must have the [evil bit](https://datatracker.ietf.org/doc/html/rfc3514) in the IP header set.
The objective is to find the traffic originated by humans and then to find, which trolls are complaning about this human.

To find the human, the Wireshark filter
```
!(ip.flags.rb == 1)
```
was used. It was found that the human is in room 1024.

Filtering for this room
```
urlencoded-form.value contains "room 1024"
```
reveals that Yaqh, Flud and Hagg are complaining about the lady in this room.
Sorting the names results in the solution **Flud Hagg Yaqh**

**Achievement: Reading Evil Packets**
