---
layout: post
title: Unsorted uniq
category: posts
---

Everybody gets caught the first time: `uniq` filters repeated lines -- but only
if they follow each other. This assumption greatly reduces the memory footprint
of `uniq` and ... its usefulness.

I [explained previously](https://blog.jpalardy.com/posts/alternative-to-sort-uniq-c/) how awk
could be used to replace the classic `sort | uniq -c` incantation. In short, by
skipping the `sort`, you can scale the solution to much bigger files.

If, however, all you need is an unsorted `uniq`, there's an even shorter awk command you can use:

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

    $ cat animals.txt | awk '!cnts[$0]++'
    cats
    dogs
    birds

Broken down as:

* $0 -- the whole current line
* cnts[$0] -- hash (automatically created) lookup of the current line
* !cnts[$0] -- if not in the hash (first occurence)
* !cnts[$0]++ -- if not in the hash, also, increment by one (flagging it as "seen")
* { print $0 } -- implicit action of the conditional above, print the current line

Or, in English, print the current line if you've never seen it, and mark it seen.

As an added bonus, this command doesn't have to process the whole file, it will
print the new unique lines as they present themselves.

