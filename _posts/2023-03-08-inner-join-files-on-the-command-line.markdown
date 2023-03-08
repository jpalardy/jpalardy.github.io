---
layout: post
title: INNER JOIN Files on the Command-Line
category: posts
---

A lot of people don't know that `join` exists, or what it does 🤔

I mean the `join` command that's already on your computer and ready to go:

{% highlight text %}
# BSD (macOS)
> join
usage: join [-a fileno | -v fileno ] [-e string] [-1 field] [-2 field]
            [-o list] [-t char] file1 file2

# or

# GNU (linux)
> join
join: missing operand
Try 'join --help' for more information.
{% endhighlight %}


## What is join?

Believe it or not, `join` is part of
[coreutils](https://www.gnu.org/software/coreutils/manual/html_node/index.html),
which -- as its name implies -- is pretty central to UNIX-like systems.

It sits there, with its better known siblings `cut` and `paste`

[![together: cut, paste and join](/assets/inner-join-cli/sample-cores.png)](/assets/inner-join-cli/sample-cores.png)

What does `join` do?

`join` does to files what SQL `INNER JOIN` does to tables.

## join Examples

Imagine two files:

{% highlight bash %}
> cat english.txt
1 one
2 two
3 three
4 four

> cat spanish.txt
1 uno
2 dos
4 cuatro
{% endhighlight %}

By default, the first column (numbers here, but it doesn't have to be) is the join key:

{% highlight bash %}
> join english.txt spanish.txt
1 one uno
2 two dos
4 four cuatro
{% endhighlight %}

Notice that `3` is missing from `spanish.txt`. It works the way `INNER JOIN` works.

Same, flipping the files: (`3` still missing)

{% highlight bash %}
> join spanish.txt english.txt
1 uno one
2 dos two
4 cuatro four
{% endhighlight %}

Comments:
- files must be sorted ~ that's important!
- fields are separated by blanks -- but field separator can be specified with `-t`
- there are other options, check the [man page](https://linux.die.net/man/1/join) as needed

You can even coerce `join` into doing:
- `LEFT JOIN`
- `RIGHT JOIN`
- `UNION`
- `DIFFERENCE`

check the [online documentation](https://www.gnu.org/software/coreutils/manual/html_node/Paired-and-unpaired-lines.html) for examples.

## Is join Useful?

I recently had to join 2 large [.tsv](https://en.wikipedia.org/wiki/Tab-separated_values) files. My first instinct was to reach for
[AWK](https://blog.jpalardy.com/posts/why-learn-awk/) ... but I remembered `join` and it did **exactly** what I needed.

Knowing that `join` exists is 80% of its value 😄

