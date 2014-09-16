---
layout: post
title: One-liner Bash Functions
category: posts
---

Here's a problem:

{% highlight bash %}
$ grep something file
{% endhighlight %}

If you're going to search for different strings, repeatedly, what you really
want is for "something" to be the last argument. This is true even if you
master the
[keyboard](http://www.howtogeek.com/howto/ubuntu/keyboard-shortcuts-for-bash-command-shell-for-ubuntu-debian-suse-redhat-linux-etc/)
[shortcuts](http://www.bigsmoke.us/readline/shortcuts) to minimize the pain.

While bash doesn't support anonymous functions, it's casual about aliases and
named functions. It's easy to create a function in the current session and it
will disappear when you exit the shell. Here's a bash function to solve our
argument problem:

{% highlight bash %}
grep_file() {
  grep "$@" file
}
{% endhighlight %}

But it's not convenient to define a bash function like this: as you press enter
between the lines, you can't go back and edit the top of the function.
You _could_ type the function in a file and source it, but it breaks
the flow of what you're doing.

If you've ever tried to type the function on one line, you've seen this situation:

{% highlight bash %}
$ grep_file() { grep "$@" file }
>
{% endhighlight %}

You're stuck on the next line, and bash is waiting for input ... as if you had
forgotten to close a string or a parenthesis.

The solution is explained on [this page](http://tldp.org/LDP/abs/html/functions.html):

[![one line bash function](/assets/one-liner-bash-functions/semicolon.png)](http://tldp.org/LDP/abs/html/functions.html)

It's all about that semicolon:

{% highlight bash %}
$ grep_file() { grep "$@" file; }
{% endhighlight %}

