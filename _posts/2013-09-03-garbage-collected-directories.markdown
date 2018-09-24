---
layout: post
title: "Garbage Collected Directories"
category: posts
---

"I wish all these temporary directories wouldn't clutter my home directory."

We are all familiar with directories cleverly named "tmp", "test", "whatever",
or "DELETE-ME". These directories are usually created for short-lived
experiments or to contain a "mess".

For example: you download a package, untar/gunzip it, `./configure; make; make
install`. You start to play with what you installed and forget about the
directory you're leaving behind. That clutter will haunt you later.

I created a simple script to clean up after myself, I call it `tad` (__t__hrow-__a__way
__d__irectory). The [code](https://github.com/jpalardy/dotfiles/blob/master/bash/commands/tad.bash) is on Github, but
here's a snapshot:

{% highlight bash %}
tad() {
  local ts=$(date +%s)
  local d="$HOME/.throw-away/$ts"
  mkdir -p $d
  (cd $d; bash)
  rm -r $d
}
{% endhighlight %}

It creates a directory under `$HOME/.throw-away`, changes (cd) into it and
launches a shell there. When the shell exits, the directory is deleted with all
its content.

In practice, it means that I type `tad` and I'm in a sandbox. And when I exit
the shell, the sandbox is gone, and I'm back in the original directory from
which I issued the command. This script is the formalization of something I
used to do manually.

What does it mean to have garbage collection for directories?

It changes the way you work. I have had this script for quite some time: I use
it all the time and keep finding new ways to use it. Not having to name the
directory and not having to clean up _frees_ me -- those things are
[accidental complexity](http://en.wikipedia.org/wiki/Accidental_complexity).

