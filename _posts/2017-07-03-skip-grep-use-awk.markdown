---
layout: post
title: "SKIP grep, use AWK"
category: posts
---

Over the years, I've seen many people use this pattern (filter-map):

{% highlight bash %}
$ [data is generated] | grep something | awk '{print $2}'
{% endhighlight %}

but it can be shortened to:

{% highlight bash %}
$ [data is generated] | awk '/something/ {print $2}'
{% endhighlight %}


## You (probably) don't need grep

Following this logic, you can replace a simple grep with:

{% highlight bash %}
$ [data is generated] | awk '/something/'
{% endhighlight %}

This will _implicitly_ print lines that match the regular expression.

If feel lost, I've got an illuminating
[series](/posts/why-learn-awk/) of
[posts](/posts/awk-tutorial-part-1/) about
[awk](/posts/awk-tutorial-part-2/) for
[you](/posts/awk-tutorial-part-3/).


## Why would I do this?

I can think of 4 reasons:

- it's shorter to type
- it spawns one less process
- awk uses modern (read "Perl") regular expressions, by default -- like `grep -E`
- it's ready to "augment" with more awk


## But "grep -v" is OK...

It's _possible_ to emulate `grep -v` with awk, but it's not a good idea:

{% highlight bash %}
$ [data is generated] | awk '/something/ {next} 1'
{% endhighlight %}

- it's uglier
- it's longer than `grep -v`
- "what's does that even do?!" -- it requires a deeper understanding of awk

**UPDATE:**

Many people have pointed out that "grep -v" can be done more consicely with:

{% highlight bash %}
$ [data is generated] | awk '! /something/'
{% endhighlight %}

which isn't too bad at all.

