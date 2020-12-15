---
layout: post
title: Splitting A File Based On Its Content
category: posts
---

My [previous post](https://blog.jpalardy.com/posts/alternative-to-sort-uniq-c/)
reminded me of a similar problem: how do you split a file based on its content?
Counting might be one of the things you want to do with each subset of the
file.

    $ cat sample.data
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

    $ cat sample.data | awk '{ print > $1 ".data" }'

    $ ls
    birds.data  cats.data  dogs.data  sample.data

    $ wc -l *.data
           3 birds.data
           4 cats.data
           5 dogs.data
          12 sample.data
          24 total

For those not comfortable with `awk`:

* print the whole line (`print $0` and `print`, by itself, are the same)
* redirect (>) to a filename formed by the concatenation of $1 (the first field) and ".data"

IMPORTANT: redirection is slightly different in awk than on the shell. Like in
`bash`, > means overwrite and >> means append, but in `awk` the file is only
opened once per session (and closed automatically at the end). That's why the
files will contain all the matching lines and not only the last matched line. ([details](https://www.gnu.org/software/gawk/manual/html_node/Redirection.html))

Without `awk`, I managed to make this work by extracting each unique line (k
uniques) and by iterating over the whole file (n lines) to extract each
subset... it was clumsy and slow: O(k × n).

This is a general technique, but I usually use it to split HTTP server log files by:

* calendar days (2014-03-11)
* hours (15)
* HTTP statuses (200, 404, 503 … also: 2xx, 3xx, 4xx, 5xx)
* URLs

to count requests, review in Vim, and, probably, do some calculations on durations.

It's possible to do the calculations directly in `awk` in one pass, but I find
that splitting the file isn't wasteful if you're not sure exactly how you'll
treat the data -- each subset file will be smaller and easier to deal with than
the whole. It can be painful to run a long job on a file and find your logic
faulty. It's better to do multiple passes, each trivial.

