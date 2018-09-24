---
layout: post
title: Awk Tutorial, part 2
category: posts
---

I [already mentioned](https://blog.jpalardy.com/posts/why-learn-awk/) why you should learn AWK.  
In [part 1](https://blog.jpalardy.com/posts/awk-tutorial-part-1/), we laid a _solid_ foundation.  
Let's build on top of that.

_NOTE: certain command outputs have been pretty-printed. Pipe through `column -t` to obtain similar results._

## Matching with Regular Expressions

So far, I've shown you ways to match lines based on column values. In practice,
you usually want to match lines with regular expressions. For example, you can
extract data from 2015:

{% highlight txt %}
$ cat netflix.tsv | awk '/^2015-/'
2015-12-31  116.209999  117.459999  114.279999  114.379997  9245000  114.379997
2015-12-30  118.949997  119.019997  116.43      116.709999  8116200  116.709999
2015-12-29  118.190002  119.599998  116.919998  119.120003  8159200  119.120003
2015-12-28  117.260002  117.349998  113.849998  117.110001  8406300  117.110001
2015-12-24  118.220001  118.800003  117.300003  117.330002  3531300  117.330002
# snip
{% endhighlight %}

(_achievement unlocked: you have re-created grep..._)

A regular expression, by itself, is a shorthand for the condition: `$0 ~ /regex/`

{% highlight bash %}
awk '/^2015-/'
# means:
awk '$0 ~ /^2015-/'
{% endhighlight %}

This means you can match regular expressions on _specific_ columns. You can
extract the data for the 1st of every month:

{% highlight txt %}
$ cat netflix.tsv | awk '$1 ~ /-01$/'
2016-03-01  94.580002   99.160004   93.610001   98.300003   16997700  98.300003
2016-02-01  91.790001   97.18       91.300003   94.089996   19618000  94.089996
2015-12-01  124.470001  125.57      122.419998  125.370003  12528800  125.370003
2015-10-01  102.910004  106.110001  101.120003  105.980003  17426900  105.980003
2015-09-01  109.349998  111.239998  103.82      105.790001  35977100  105.790001
# snip
{% endhighlight %}

That's already way better than grep.


## Comparisons and Logic

I glossed over that in [part 1](https://blog.jpalardy.com/posts/awk-tutorial-part-1/),
but AWK has all the usual comparison operators:

{% highlight bash %}
$2 == 124.47   # equality
$2 != 124.47   # inequality

$2 > 124.47    # greater than
$2 >= 124.47   # greater than or equal
$2 < 124.47    # smaller than
$2 <= 124.47   # smaller than or equal

$2 ~ /^10.$/   # regex match
$2 !~ /^10.$/  # regex negated match  -- this one might be new
{% endhighlight %}

and logical operators:

{% highlight bash %}
$1 ~ /^2015/ && $6 > 20000000  # and -- high volume in 2015
$6 < 1000000 || $6 > 20000000  # or  -- low or high volume
! /^2015/                      # not -- not in 2015
{% endhighlight %}

You can _almost_ create arbitrarily complex conditions. You are missing variables...


## Built-in Variables

Some variables just "exist"; they already contain values and are automatically
updated. These variables are easy to recognize because they are named
in CAPITAL letters. Exception: column variables (starting with a $)
are also built-in variables.

There are a [bunch](http://www.math.utah.edu/docs/info/gawk_11.html)
of built-in variables, but you'll mostly use 2:

* NR : the number of records (lines) processed since AWK started
* NF : the number of fields (columns) on the current line

And 2 more if you're dealing with multiple files:

* FNR : like NR, but resets to 1 when it begins processing a new file
* FILENAME: the name of the file being currently processed


## User-Defined Variables

There is no need to "declare" the variable or initialize it. A variable "comes
to life" when you use it. You can count (and print) how many lines happened in December
2015:

{% highlight txt %}
$ cat netflix.tsv | awk '/^2015-12/ {count++; print count, $0}'
1   2015-12-31  116.209999  117.459999  114.279999  114.379997  9245000   114.379997
2   2015-12-30  118.949997  119.019997  116.43      116.709999  8116200   116.709999
3   2015-12-29  118.190002  119.599998  116.919998  119.120003  8159200   119.120003
4   2015-12-28  117.260002  117.349998  113.849998  117.110001  8406300   117.110001
5   2015-12-24  118.220001  118.800003  117.300003  117.330002  3531300   117.330002
# snip
22  2015-12-01  124.470001  125.57      122.419998  125.370003  12528800  125.370003
{% endhighlight %}

Not having to declare variables is _convenient_, but it's also error-prone. If
you misspell a variable, there won't be any warning, and it might take you a
while to discover your mistake. You've been warned. **Remember:** this is a
language that optimizes for one-liners.

What are variables initialized to?

{% highlight txt %}
$ awk 'BEGIN {print x + 2}'          # => 2
$ awk 'BEGIN {x = x + 2; print x}'   # => 2
$ awk 'BEGIN {print x}'              # => <blank> -- empty string, really
# BEGIN will be discussed next...
{% endhighlight %}

An undefined `x` contains the empty string. The first time you access
it, that's what you get. Strings are converted to numbers for numerical
operations:

{% highlight txt %}
x + 2
# expands:
"" + 2
# expands:
0 + 2
# expands:
2
{% endhighlight %}


## Special Patterns: BEGIN and END

`BEGIN` and `END` are special conditions that only get triggered once per run.

* `BEGIN` gets triggered _before_ processing any line
* `END` gets triggered _after_ all lines have been processed

These conditions get triggered _even if_ there are no input lines.

`BEGIN` is usually used to initialize variables -- though now you know that's not
necessary for zeroes or empty strings. It can also be used to print a header.

`END` is usually used to crunch a result and print a summary or report:

{% highlight txt %}
$ cat netflix.tsv | awk 'END {print NR}'
{% endhighlight %}

(_achievement unlocked: you have re-created wc -l..._)


## Blocks and Control

You can have multiple condition-block pairs. Each line in the input files gets
presented to each block you write:

{% highlight txt %}
$ cat netflix.tsv | awk '/^2016-03-24/ {print} $4 == 96.43 {print}'
2016-03-24  98.639999  98.849998  97.07  98.360001  10646900  98.360001
2016-03-15  97.870003  98.510002  96.43  97.860001  9678000   97.860001

# could be written as:
#
# $ cat netflix.tsv | awk '/^2016-03-24/; $4 == 96.43'
#
# because we both know what a missing block means...
# but for this example, it's a bit opaque.
{% endhighlight %}

That works great until you have a line that matches both conditions:

{% highlight txt %}
$ cat netflix.tsv | awk '/^2016-03-24/ {print} $4 == 97.07 {print}'
2016-03-24  98.639999  98.849998  97.07  98.360001  10646900  98.360001
2016-03-24  98.639999  98.849998  97.07  98.360001  10646900  98.360001
{% endhighlight %}

The same line was printed twice! There are two solutions to this problem:

* making your conditions mutually exclusive  
  (which *could* be easy, but is often tedious and redundant)
* using the `next` statement:

{% highlight txt %}
$ cat netflix.tsv | awk '/^2016-03-24/ {print; next} $4 == 97.07 {print}'
2016-03-24  98.639999  98.849998  97.07  98.360001  10646900  98.360001
{% endhighlight %}

If you hit a `next`, your script will stop matching blocks and go to the
_next_ line from the input file. Using `next` means you have to think about the
order of your blocks.  
That's not necessarily a bad thing.

There's also an `exit` statement to stop processing any more input and _exit_ your script.
The `END` block will still be executed, if you have one.


## Taking inventory: what can you do?

At this point, a better question would be: what _can't_ you do?

In review, you can:

* match a line with regular expressions
* match a line with any operator
* use built-in variables, both in conditions or in blocks
* use your own variables, for all other needs
* control what happens at the beginning and the end of your script
* skip lines or exit early


## Exercises

Try to:

* only print lines between February 29, 2016 and March 4, 2016
* sum the volumes for all days of January 2016
* average the closing price over all days of March 2015
* check that _all_ lines have 7 columns
* only print every other line (say, even lines)
* remove empty lines in a file

Answers are [here]({{site.url}}/assets/awk-tutorials/answers-part2.txt).

## What's next?

[Part 3](https://blog.jpalardy.com/posts/awk-tutorial-part-3/)

