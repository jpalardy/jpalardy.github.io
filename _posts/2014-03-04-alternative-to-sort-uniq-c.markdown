---
layout: post
title: Alternative to sort | uniq -c
category: posts
---

It's an old trick, use `sort | uniq -c` to count the unique lines from a file:

    $ cat animals.txt
    cats
    cats
    cats
    dogs
    birds
    cats
    dogs
    dogs
    birds
    dogs
    dogs
    birds

    $ cat animals.txt | sort | uniq -c
    3 birds
    4 cats
    5 dogs

`uniq -c` does the counting, but it has to come after a `sort`. `sort` is
usually fast enough for most day to day usage on the command-line. That was
until recently, when I had to count from a file with 72 million lines... I let
`sort` run because I was curious, and it took 38 minutes (!) to process the file.

The "problem", of course, is sorting. While `sort` performs surprisingly well with files
having up to millions of lines, you can't escape its property: it must use an
[n log n](http://en.wikipedia.org/wiki/Sorting_algorithm) algorithm.

Here's the `awk` code equivalent to the `sort | uniq -c` above:

    $ cat animals.txt | awk '{ cnts[$0] += 1 } END { for (v in cnts) print cnts[v], v }'
    5 dogs
    3 birds
    4 cats

For those not comfortable with `awk`:

* use the whole line ($0) as a key
* every occurence of $0 get += 1 in a hash (cnts)
* at the END of the file, iterate over every entry in the hash, print the key and its count

I don't bother optimizing my command-line counting unless I know I'm working
with a big file. Even then, I don't type the above, I just paste it from my
notes.

For the record: `awk` took only 2 minutes to process that file with 72 million lines.

