---
layout: post
title: "Comments on the Command-Line"
category: posts
---

Most shells support comments with the `#` symbol. At first glance, that's
obvious because shell commands can be turned into shell scripts ... and all
programming languages have comments.

But comments are more complicated than they seem; their [uses](https://en.wikipedia.org/wiki/Comment_(computer_programming)#Uses)
vary:

- documentation
- explanations
- compiler annotations, sometimes
- debugging -- commenting out code
- tagging -- TODO, FIXME, etc...

## What makes shell comments different?

Shell comments are part of the shell's history!

If you type a command and add a trailing comment, it's going to `history`:

{% highlight bash %}
> gzip report.html # send to bob later
> history | tail
# snip
894  gzip report.html # send to bob later
895  history | tail
>
{% endhighlight %}

I was surprised: that's not how I imagined the shell would behave (by default).

And though that's a cute use of shell comments, it's not necessarily something
I would recommend. I wouldn't build a workflow around this...

## How to leverage this?

Personally, I use this feature when:

- I'm in the middle of typing a command
- something else happens, I need to pause this...
- but I don't want to lose my "work"

It might be because I need to consult a man page, or because I need to do
something else first. In those cases, I go to the beginning of the line (<kbd>ctrl-a</kbd>)
and comment out the whole thing:

{% highlight bash %}
> # cat data.csv | awk -F, '{print $3}' | sort | uniq -c
> history | tail
# snip
896  # cat data.csv | awk -F, '{print $3}' | sort | uniq -c
897  history | tail
>
{% endhighlight %}

In that case, shell comments can be the `git stash` of your command-line session 😄

