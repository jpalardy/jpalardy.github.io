---
layout: post
title: "How To Shuffle and Sample on the Command-Line"
category: posts
---

## Shuffling

How do you shuffle on the command-line? With `shuf`:

{% highlight bash %}
> seq 5          # sequence from 1..5
1
2
3
4
5

> seq 5 | shuf   # same sequence, shuffled
4
3
2
1
5
{% endhighlight %}

On Linux, you already have `shuf`.

On Mac OS X, `brew install coreutils` installs shuf as `gshuf` (g for GNU), but
I usually alias gshuf to shuf to fix that.

You _could_ use `sort -R` / `sort --random-sort` as a poor-man shuf. For larger
files, that's a terrible idea because sort will sort the whole file _before_
shuffling.


## Sampling

Sampling is _the selection of a subset of individuals from within a statistical population_ -- [wikipedia](https://en.wikipedia.org/wiki/Sampling_(statistics\)).

You have to pass the `-n` flag to `shuf`:

{% highlight bash %}
> seq 100 | shuf -n 5     # pick 5 from 1..100
78
71
74
4
52
{% endhighlight %}

You can allow repeated picks of the same value with the `-r` flag:

{% highlight bash %}
> seq 5 | shuf -r -n 10   # pick 10 from 1..5, with repeats
2
2
1
1
2
5
4
3
3
2

> seq 5 | shuf -n 10      # pick 10 from 1..5, WITHOUT repeats
2
1
3
5
4
{% endhighlight %}

Picking one thing is simply:

{% highlight bash %}
> seq 100 | shuf -n 1     # pick 1 from 1..100
37
{% endhighlight %}


## Why Shuffle? Why Sample?

Every time I'm faced with too many things to look at, I don't trust myself for
picking a representative sample. It's too easy to say "I'll pick the first 10"
and to miss a problem that only happened later.

For example, you might have a system that generates files in a directory. There
might be hundreds or thousands of files and you only want to get a feel for
their content.

{% highlight bash %}
> find . -type f | shuf -n 10    # pick 10 files...
{% endhighlight %}

Or you might want to get a feel for what's happening in a log file:

{% highlight bash %}
> cat /var/log/nginx/access.log | shuf -n 100
{% endhighlight %}

Depending on your specific situation, it might bring the interesting question
of [how many things to look at](https://blog.jpalardy.com/posts/statistics-how-many-would-you-check/).

