---
layout: post
title: When to use "cat -n" instead of "wc -l"
category: posts
---

## Problem

`wc -l` is pretty good at counting lines, it's what most people use

{% highlight bash %}
# man cat | wc -l
71
{% endhighlight %}

Except that it collapses all your data to a single number.

There's nothing wrong with that if you're only trying to get the answer.

But when you're building long one-liners with multiple pipes, it's useful to answer two questions at the same time
- how many lines is that?
- are those lines what I expect?

## Quizzes

For example:

- does `seq 3 14` include 14 or not?
- how many numbers is that?

<details>
<summary>show answers</summary>

{% highlight bash %}
# seq 3 14 | cat -n
     1  3
     2  4
     3  5
     4  6
     5  7
     6  8
     7  9
     8  10
     9  11
    10  12
    11  13
    12  14
{% endhighlight %}
</details>

<br>

How about:
- how many 5-letter English words have a `b` in the 2nd letter and end with `t`?
- what are they?
- do they all start with `a`?

<details>
<summary>show answers</summary>

{% highlight bash %}
# look . | grep '^.b..t$' | cat -n
     1  abaft
     2  abbot
     3  abdat
     4  abnet
     5  abort
     6  about
     7  abret
     8  absit
{% endhighlight %}
</details>

## cat -n

The [cat](https://www.man7.org/linux/man-pages/man1/cat.1.html) command doesn't have too many flags, but more than I expected.
The exact details will depend on the GNU or BSD variant.

```text
-n, --number
    number all output lines
```

So, while it seems that you might only use `cat -n` to print a file with line numbers, keep in mind that the last line number is `wc -l`

[![man cat \| cat -n](/assets/cat-n/man-cat-cat-n.jpg)](/assets/cat-n/man-cat-cat-n.jpg)

