---
layout: post
title: "Grep and Output Buffering"
category: posts
---

Why does this work?

{% highlight bash %}
tail -f some.log | grep something
{% endhighlight %}

But this doesn't?

{% highlight bash %}
tail -f some.log | grep something | cut -c -$(tput cols)
{% endhighlight %}

(It doesn't matter what's on the 3rd pipe, but, in this case, it crops on terminal
width -- it's similar to `set nowrap` in vim)

I had been bitten many times by something like this, and it seemed like this
command would either:

- not output anything (at least for a time), then:
- output pages in bursts

Clearly, it is a buffering problem, but where's the problem: `grep` or `cut`?
How could it be `grep` if my second example worked?

## Reproducing the problem

I went with this code:

{% highlight bash %}
# generator.bash
for i in {1..1000}; do
  echo "this is line $i"
  sleep 1
done
{% endhighlight %}

which is meant to mimic the log output of some running daemon. It outputs lines
slowly because it will cause more buffering issues. Now run this:

{% highlight bash %}
bash generator.bash | grep line | cut -c 9-
{% endhighlight %}

Where's the output? What's the problem? How do you fix this?

## Solutions

[How to fix stdio buffering](https://www.perkin.org.uk/posts/how-to-fix-stdio-buffering.html) gave me most of the answer. `grep` has
a flag for this:

{% highlight bash %}
bash generator.bash | grep --line-buffered line | cut -c 9-
{% endhighlight %}

but a more general answer might be to use `stdbuf` (on Linux):

{% highlight bash %}
bash generator.bash | stdbuf -o0 grep line | cut -c 9-
{% endhighlight %}

Bonus round:

* `tail -f` keeps flushing its STDOUT, so it doesn't cause a problem.
* `awk` doesn't buffer either
* `sed` has the `--unbuffered` flag

## Why?

The above article linked to the very interesting [buffering in standard streams](https://www.pixelbeat.org/programming/stdio_buffering/).
Here's how buffering is usually set up:

* STDIN is always buffered.
* STDERR is never buffered.
* if STDOUT is a terminal, line buffering will be automatically selected. Otherwise, block buffering (probably 4096 bytes) will be used.

I have used the command-line for years without worrying about this, but these 3
points explain all "weird" behaviors.

