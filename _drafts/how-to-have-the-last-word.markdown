---
layout: post
title: How to Have the Last Word (on the command-line)
category: posts
---

Have you ever done this?

{% highlight bash %}
% mkdir some_dir
% cd some_dir
{% endhighlight %}

Did you type `some_dir` twice? Here's the same task, done in 3 different ways.

## Worst: doing it manually

![doing it manually]({{site.url}}/assets/last-word/manually.gif)

This is the looooong way. I'm typing everything and pretending I'm on a
typewriter.

## Better: using the history

![using the history]({{site.url}}/assets/last-word/history.gif)

I'm using `!$` (the last word from the previous command) instead of typing it
out. Better still, I'm using 'magic-space' to do history expansion and check
what I'm going to get.

More on "magic-space" on [this page](http://www.ukuug.org/events/linux2003/papers/bash_tips/),
scroll to slide 15.

## Best: using ESC-.

![using esc-dot]({{site.url}}/assets/last-word/esc-dot.gif)

How did the directory's name just appear? There *is* a keyboard shortcut for that
and it's *already* configured on your terminal: just type `ESC` followed by the
period (`ESC-.`).

(It also works as `META-`. or `ALT-.`)

If you keep pressing `ESC-.`, it will traverse the history backward and insert
the last word from previous commands.

## Discussion

There are a lot of commands that take a "target" as their last argument:

* cd
* cp / mv / rm
* rmdir / mkdir
* grep
* cat / touch
* (any text editor)

It's not uncommon to chain multiple of these commands on the same "target". You
just created directory, you might very well want to step into it.

Let the command-line help.

