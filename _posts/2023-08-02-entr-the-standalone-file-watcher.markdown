---
layout: post
title: 'entr: The Standalone File Watcher'
category: posts
---

## What is entr?

[entr](http://eradman.com/entrproject/) is _just_ a file watcher. The [README](https://github.com/eradman/entr) says:

> Run arbitrary commands when files change

It's available for most package managers: `brew install entr`

## A simple example

List the files you're interested in, one per line:

{% highlight bash %}
> ls *.txt
a.txt
b.txt
c.txt
{% endhighlight %}

Now feed them to `entr` with the command you want to run:

{% highlight bash %}
> ls *.txt | entr make
{% endhighlight %}

## Why entr?

A lot of projects and languages have their own "watcher" or "--watch" flag.

But I enjoy tools that work with everything that I want to do.

Even if you feel that [webpack](https://webpack.js.org/) (for example) is fulfilling all your needs, would you use it
to watch a few `.txt` files and trigger some custom job?

I don't want every tool to roll out their own "watcher". That's not the [Unix philosophy](https://en.wikipedia.org/wiki/Unix_philosophy).

## Detour: how to list files, one per line

Usually, you would feed the output of `ls` or `find` to `entr`.

There are occasions where that list will be [too large](https://eradman.com/entrproject/limits.html). Or, you might want a custom
list of files. How do you print arguments one per line?

{% highlight bash %}
> printf "%s\n" a.txt b.txt c.txt
a.txt
b.txt
c.txt
{% endhighlight %}

(see: [Why is printf better than echo?](https://unix.stackexchange.com/questions/65803/why-is-printf-better-than-echo))

Other options I've used:

{% highlight bash %}
# output of "grep"
> rg -l query

# current in-play git files
> git status --short | sed 's/^...//'
# or some other git-generated list

# specific source file and its test file
> printf "%s\n" lib/whatever.ex test/whatever.exs
{% endhighlight %}

## Noteworthy tips

The source of truth is the [man page](http://eradman.com/entrproject/entr.1.html).
Here are a few tips:

- the `-c` flag clears the screen every time entr triggers
- the `-r` flag restarts the command on every trigger
- the `-s` flag allows for more complete shell commands (with pipe...)
- hitting 'space' will manually force-trigger entr
- `/_` stands for the first file to trigger an event

I also found that combining `entr` with [ding](/posts/ding/) allows me to run "headless"

{% highlight bash %}
> printf "%s\n" lib/whatever.ex test/whatever.exs | entr ding mix test
{% endhighlight %}

I can hear when tests pass/fail based on the exit code. 😎

