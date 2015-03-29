---
layout: post
title: Inverse Globbing
category: posts
---

This felt like a command-line blind spot: is it possible to invert a glob?

What's the opposite of `rm *.mp3`? How would you delete everything _except_ the
MP3 files?

It turns out that there's a syntax for that:

{% highlight bash %}
rm !(*.mp3)
{% endhighlight %}

if you put `shopt -s extglob` in your .bashrc. There are [no downsides](http://stackoverflow.com/questions/17191622/why-would-i-not-leave-extglob-enabled-in-bash)
to using that config. Extended globbing allows you to do [other things](http://mywiki.wooledge.org/glob) too.

Without extended globbing, you could try:

{% highlight bash %}
rm $(ls | grep -v mp3$)
{% endhighlight %}

but that won't account for filenames with spaces and other characters that
would need to be escaped.

