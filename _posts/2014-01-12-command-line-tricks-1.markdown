---
layout: post
title: "Command-line Tricks #1"
category: posts
---

No matter how long you use the command-line, there's always more to learn.
Here's an account of things I learned recently.

## which -a

The command `which` is not a revelation, most people are aware of it. You type:

{% highlight bash %}
    % which find
    /usr/bin/find
{% endhighlight %}

and you get the full path of that executable. This is useful if you have
multiple copies of an executable in different places in your PATH and you are
wondering which one would be used.

Sometimes, you want to see ALL the matching executables in your PATH. That's
what the `-a` flag is for:

{% highlight bash %}
    % which -a awk
    /Users/jonathan/local/bin/awk
    /usr/local/bin/awk
    /usr/bin/awk
{% endhighlight %}

I had a vague notion that the `whereis` command was used to answer such
questions. Unfortunately, it does something relatively useless:

> The whereis utility checks the standard binary directories for the specified
> programs, printing out the paths of any it finds.

The key point being "standard binary directories", that is "where stuff is supposed to be",
that is "I'm not going to check your PATH"... I was enlightened by
[this answer](http://superuser.com/a/430004) on superuser.com.

