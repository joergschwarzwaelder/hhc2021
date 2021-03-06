
# Objective 2: Where in the World is Caramel Santaigo
**Location: Courtyard, Santa's Castle, Ground Floor**  
**Elf: Tangle Coalbox**

**Hints provided by Piney Sappington after completion of [Exif Metadata](https://github.com/joergschwarzwaelder/hhc2021/blob/master/Additional/Exif%20Metadata.md)**

This objective based on a game in a Cranberry Pi terminal.
It is about travelling through the world, obtaining hints about the next location and the Elf to be searched and finally guessing the right Elf whilst being at the right location.
This is similar to the game "[Where in the World Is Carmen Sandiego?](https://en.wikipedia.org/wiki/Where_in_the_World_Is_Carmen_Sandiego?_%281985_video_game%29)" from 1985.

The full state information of this game is stored in the browser in a Flask cookie named **Cookiepella**:

```
Cookie: Cookiepella

.eJyFUk1v1DAQ_Ssjc-CSRfuVzcetLAiKBK2ackC7HCb25IM4duQ4uwpV_3vHsIciKjjZnnnz5vnNPAiFs8jFZ2vCJRKkK34WA7pOE9yRKsm5S-Jja_wo8oO4aSK4BmN9K0mBb2iGBhUgFB4d3DvqQrDn3NBYQyBxpDfMcd8QMA_0ZHzLCQWj7ck3rakBSzv5QCA7uDmRq7Q9AxoF-1fPS2vrwRFqzS0JPVP8LpzGQDIOKGmEyjpojeIu46V2ho4GD7Ih2QUgy2tZ6bn1nhzgMARcg06J73zayYk8i4S2EoPQ4Agaj69H2OPoNTHYDiET7DiIW4f1RBHsf5Js2LRhKnUrGbS3A5kGazIRvCPTs6scvTL-TG6I4C3pup167nkQdzR3P_B0nJZLUh37K0nz94N82802gk84oOHnFzrDN-sY8rW4-k_pe9WacnI1z6uQ1l-ihZ-8r9H5CD6Q69HMv2huNZvXWK3IvQz6qzd75ZjS9gWREnm8jjnA06CwJC___U-G6B_an8vhRqdWeutmNoPCPB5448YmPwqZylUaVxTHMapNtYsTqbIsKbFUabbaldU6oU2MscQVbjcqXm-3y6ySSbLDTK7T5VFEvFAjj1zStcrhKAJKpVW6YObNYpuo3QJ3m-0iXm2rZJmm67SqjuJRPD4BmcoPHw.YbtK9g.QPkBCWdhCO0zFuEcPjNy6okWRQg
```
In order to get this information, the part between the leading dot and the second dot has to be decoded with [Cyberchef](https://gchq.github.io/CyberChef/) using a Base64 decode with URL-safe alphabet followed by a Zlib inflate. This results in a JSON containing the data required to win the game:

![Cyberchef](https://github.com/joergschwarzwaelder/hhc2021/blob/master/Objective-2/cyberchef.png)
So in this specific case:

 - Travel to Copenhagen
 - Travel to New York
 - Travel to Reykjavik
 - The Elf found is Sparkle Redberry

**Achievement: Where in the World in Caramel Santaigo**
