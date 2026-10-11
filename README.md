# Vowel Counter (MIPS Assembly)

A MIPS assembly program that counts the vowels (a, e, i, o, u) in a text file.

## What it does

- Opens a text file named `book.txt`.
- Reads it in chunks of 4,096 characters, so the file can be as long as a full book.
- Passes each chunk to a `countvowels` function that treats capital and lowercase letters the same.
- Adds up the totals and prints the result, for example `vowels: 123456`.
- Prints `could not open file` if the text file can't be found.

Only a, e, i, o, and u are counted. The letter "y" is not.

## How to run

1. Open `countvowels.s` in [MARS](https://dpetersanderson.github.io/) (the MIPS simulator).
2. Put a text file named `book.txt` where MARS can find it. If MARS can't find it, change the filename at the top of `countvowels.s` to the full path of your file.
3. Assemble the program, then run it.
4. The total number of vowels appears in the output window.

## Why I wrote it

The idea came from a linguistics class about the role of vowels in language. It made me curious how many vowels show up in a long text, like a 300-page book.
