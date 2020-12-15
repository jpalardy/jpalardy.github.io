---
layout: post
title: "Why Learn AWK?"
category: posts
---

Because of the arcane syntax?  
Because other languages can't do the job?

No.

I resisted AWK for a long time. Couldn't I already do everything I needed with
sed and grep? I felt that anything more complex should be done with a "real"
language. AWK seemed like yet-another-thing to learn, with marginal benefits.


## Why Learn AWK?

Let me count the ways.

### You are working TOO HARD

Too many times, I've seen people working _way_ too hard at the command-line trying to
solve simple tasks.

Imagine programming without regular expressions.

Can you even _imagine_ the alternative? Would it entail building [FSM](https://en.wikipedia.org/wiki/Finite-state_machine)s
from scratch? Would it be easy to program? Would it be fun? Would it work the way you want?

That's life without AWK.

For simple tasks ("only print column 3" or "sum the numbers from column 2")
_almost_ falling in the "grep-and-sed" category, but where you feel you might
need to open a man page, AWK is usually the solution.

And if you think that creating a new script file (`column_3.py` or `sum_col_2.rb`),
putting it somewhere on disk, and invoking it on your data isn't bad -- I'm
telling you that you're working too hard.


### Available EVERYWHERE

On Linux, BSD, or Mac OS, AWK is already available. It is [required](https://en.wikipedia.org/wiki/POSIX#Overview) by any
POSIX-compliant OS.

More importantly, it will be the AWK you know. It has been around for a long
time, and the way it works is stable. Any upgrade would not (could not) break
your scripts -- it's the closest thing to "it just works".

Contrast with BASH or Python ... do you have the right version? Does it have
_all_ the language features you need? Is it backward and forward compatible?

When I write a script in AWK, I know 2 things:

- AWK is going to be anywhere I deploy
- it's going to work


### Scope

You shouldn't write anything complicated in AWK. That's a **feature** -- it
limits what you're going to attempt with the language. You are not going to
write a web server in AWK, and you know it wouldn't be a good idea.

There's something refreshing about knowing that you're not going to import a library
(let alone a framework), and worry about dependencies.

You're writing an AWK script, and you're going to focus on what AWK is good at.


### Language Features

Do you want the following? (especially compared to BASH)

* hashes
* floating-point numbers
* modern (i.e. Perl) regular expressions

It's all there, ready to go. Don't worry about the version number, the
bolted-on syntax, or the dependence on other tools.


### Convenience: minimized bureaucracy

In a script sandwich, your logic is the "meat", and the surrounding bureaucracy
is the "bread". In practice, bureaucracy means:

* opening and closing files
* iterating over each line of each file
* parsing or breaking a line into fields

These things are _needed_ but they aren't what your script is about. AWK takes
care of all that, your code is implicitly surrounded by a loop that's going to
iterate over every input line.

DISCLAIMER: This isn't AWK, it's JavaScript. It might as well be pseudocode.
All code simplified and for illustrative purposes only.

{% highlight javascript %}
// open each file, assign content to "lines"
lines.forEach(function (line) {
  // the code you write goes here
});
// close all the files
{% endhighlight %}

AWK is going to break each line into "fields" or "columns" -- for many people,
that feature is the main reason to use AWK. By default, AWK breaks a line into
fields based on whitespace (i.e. `/\s+/`) and ignores leading or trailing
whitespace.

Also, AWK is automatically going to set a bunch of useful variables for you:

* NF -- how many fields in the current line
* NR -- what the current line number is
* $1, $2, $3 .. $9 .. -- the value of each field on the current line
* $0 -- the content of the current line
* and [more](https://www.math.utah.edu/docs/info/gawk_11.html#SEC108)

{% highlight javascript %}
// open each file, assign content to "lines"
var NR = 0;
lines.forEach(function (line) {
  NR = NR + 1;
  var fields = line.trim().split(/\s+/);
  var NF = fields.length;
  // the code you write goes here
});
// close all the files
{% endhighlight %}

### Convenience: automatic conversions

AWK does automatic string-to-number conversions. That's something terrible in
"real" programming languages, but very convenient within the scope of the things
you should attempt with AWK.

### Convenience: automatic variables

Variables are automatically created when first used; you don't need to declare variables.

{% highlight awk %}
a++
{% endhighlight %}

Let's unpack it:

* the variable `a` is created
* using `++` treats it as a number -- `a` is initialized to 0
* the `++` operator increments it

It's even more useful with hashes:

{% highlight awk %}
things[$1]++
{% endhighlight %}

* `things` is created, as a hash
* using dynamic key `$1`, a value is initialized to 0 (implicit in `++` use)
* the `++` operator increments it


### Convenience: built-in functions

AWK has a [bunch](https://www.math.utah.edu/docs/info/gawk_13.html#SEC123) of numeric and
string functions at your disposal.


## AWK is PERFECT\*

AWK is _PERFECT_ when you use it for what it's meant to do:

* very powerful one-liners
* (or) short AND portable scripts


## Now What?

Maybe I've convinced you to reconsider AWK: good.

How do you learn AWK?

There are many possibilities:

* reading a bunch of [examples](https://www.google.ca/search?q=awk+examples)
* finding a [tutorial](https://www.google.ca/search?q=awk+tutorial)
* reading the [manual](https://www.gnu.org/software/gawk/manual/gawk.html)
* reading the [book](https://www.amazon.com/dp/0596000707/)

In my [next post](/posts/awk-tutorial-part-1/), I'll explain everything you need to get you started with AWK.

