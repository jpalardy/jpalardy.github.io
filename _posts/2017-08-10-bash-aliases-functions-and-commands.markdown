---
layout: post
title: "Bash Aliases, Functions and Commands"
category: posts
---

The first thing you type on a command-line is either an alias, a function or a command.
If you haven't written it yourself, it might not be obvious _what_ exactly you're calling.

{% highlight bash %}
# defining an alias
$ alias x1="echo hello world"

# defining a function
$ x2() { echo hello world; }    # ; is important, see below

# defining a command
$ cat > /usr/local/bin/x3 <<END
#!/bin/bash
echo hello world
END
$ chmod +x /usr/local/bin/x3
{% endhighlight %}

If you're curious about `;` in the function definition, read [One-liner Bash Functions](/posts/one-liner-bash-functions/).

They all do the same thing, but you can't tell what they are:

{% highlight bash %}
$ x1
hello world

$ x2
hello world

$ x3
hello world

{% endhighlight %}

How can you tell? Use [type -a](/posts/type-a/):

{% highlight bash %}
$ type -a x1
x1 is aliased to 'echo hello world'

$ type -a x2
x2 is a function
x2 ()
{
  echo hello world
}

$ type -a x3
x3 is /usr/local/bin/x3
{% endhighlight %}

## So what?

It becomes important if you chain them. Worst case: an alias for a function that calls a command ... all with the same name:

{% highlight bash %}
$ alias x="echo from the alias; x"

$ x() {
  echo "from the function"
  command x     # To prevent recursion. There's also a 'builtin' override.
}

$ cat > /usr/local/bin/x <<END
#!/bin/bash
echo from the command
echo hello world
END
$ chmod +x /usr/local/bin/x

# calling x...
$ x
from the alias
from the function
from the command
hello world

# what am I calling?
$ type -a x
x is aliased to 'echo from the alias; x'
x is a function
x ()
{
  echo "from the function";
  command x
}
x is /usr/local/bin/x
{% endhighlight %}

The order returned by `type -a` is the evaluation order:

* aliases
* functions
* commands

## Why would you do that?

The `ls` command is often aliased. (... is `ls` a command or builtin? `type -a ls`).

Or you might do fancy things with `cd`.

The point is that you _can_ and it's _sometimes_ useful.

## When to use which?

It's [complicated](https://unix.stackexchange.com/questions/30925/in-bash-when-to-alias-when-to-script-and-when-to-write-a-function). Some guidelines:

### aliases

For trivial things, when arguments (if any) come at the end.

### functions

For more complicated things:

* positional arguments
* multi-line
* all the Bash you want
* "faster" -- stored in the shell's memory
* can modify current shell  -- you _can't_ implement `cd` as a command

### commands

For everything else:

* don't have to use Bash
* easily installed / shared -- put somewhere in PATH
* can be used by other programs, subshells...

