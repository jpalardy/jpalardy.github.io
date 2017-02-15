---
layout: post
title: "Get Your Last Downloaded File"
category: posts
---

Mac software is setup to receive files in `~/Downloads`. Since I live on the
command-line, the duality of downloading files and interacting with them is
jarring.

I wanted a way to say:

> ...get the file I just downloaded...

It's possible to tab-complete on `~/Downloads/` but that directory is usually
full of crap (possibly, that's the real problem).

I've been experimenting with the simplest way to automate this:

{% highlight bash %}
ldf() {  # stands for "last downloaded file"
  local file=~/Downloads/$(ls -1t ~/Downloads/ | head -n1)
  read -p "confirm: $file "
  mv "$file" .
}
{% endhighlight %}

Breakdown:

* `ls -1t ... | head`  
  Find the last downloaded file, based on modification time -- a reasonable assumption.
* `read -p`  
  Show me the file, wait for keyboard. I can confirm or bail out with `ctrl-c`.
* `mv`  
  Move the file to the current directory.

This hack is what I need most of the time.

__Added bonus__: you can keep calling the function if you need multiple files
... it will "pop" them out in reverse, as if from a stack.

