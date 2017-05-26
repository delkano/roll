# roll
## Introduction
**roll** is a very simple command-line dice roller written in D. It can throw any number of any type of dice, add modifiers, ace (explode) the rolls, make several independant rolls in one call, etc.

I wrote it a long time ago to try some D language and use it with Savage Worlds. Now I release the code to anyone who may want to use it.

## Usage

**roll  [<n>{a|d}<die>[+{<n>{a|d}<die>|modifier}]+]+**

As you can see, it uses any number of clauses separated by spaces, each of this is composed of:

* *n*: an integer, saying how many dices to roll
* *d|a*: *d* indicates a normal roll, *a* an exploding roll (where, if the die shows its biggest face, it is rerolled and both values added)
* *die*: the value of the di(c)e to roll. Usually 4,6,8,10,12 or 20, but it can be any positive integer.
* *modifier*: An integer to add (or substract) to the final result

### Examples

* *roll 2d6+1d4*

Rolls two 6-sided dice, one 4-sided die, and adds the three results

* *roll 1d12 2d8-2*

Rolls one 12-sided die, show its result, then roll two 8-sided dice, add them, substract 2, and show the result.
