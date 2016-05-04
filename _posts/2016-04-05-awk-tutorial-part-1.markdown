---
layout: post
title: Awk Tutorial, part 1
category: posts
---

I [already mentioned](http://blog.jpalardy.com/posts/why-learn-awk/) why you
should learn AWK.  
Let me show you how you can start using it today.

## Example Data

I think it's hard to learn AWK in a vacuum. I looked for open data on the web
and picked Netflix historical stock prices. The CSV data is available to download from
[Yahoo finance](https://finance.yahoo.com/q/hp?s=NFLX+Historical+Prices) or
[Google finance](https://www.google.com/finance/historical?q=NASDAQ%3ANFLX).
It's possible to parse this CSV data in AWK, but I replaced commas with TAB
characters to make examples easier. Here is the data we're going to use:

{% highlight txt %}
Date        Open        High        Low         Close       Volume     Adj Close
2016-03-24  98.639999   98.849998   97.07       98.360001   10646900   98.360001
2016-03-23  99.75       100.389999  98.809998   99.589996   8292300    99.589996
2016-03-22  100.480003  101.519997  99.199997   99.839996   9039500    99.839996
2016-03-21  101.150002  102.099998  99.50       101.059998  9562900    101.059998
2016-03-18  100.50      102.410004  100.010002  101.120003  15437300   101.120003
...
{% endhighlight %}

Download [the data]({{site.url}}/assets/awk-tutorials/netflix.tsv) if you want to try examples yourself.

## Printing Columns

Printing columns is probably the most useful things you can do in AWK:

{% highlight txt %}
$ cat netflix.tsv | awk '{print $2}'
Open
98.639999
99.75
100.480003
101.150002
100.50
# snip
{% endhighlight %}

Let's take it one step at a time:

* `cat netflix.tsv | awk` to send netflix.tsv to the STDIN of AWK

Alternatively, `awk '{print $2}' netflix.tsv` would have given us the same
result. For this tutorial, I use `cat` to visually separate the input data from
the AWK program itself. This also emphasizes that AWK can treat any input and
not just existing files.

* `{print $2}` to print the 2nd column

Yes, you need the curly brackets -- I'll come to that shortly. You already
guessed it: column 1 is $1, column 2 is $2, column 7 is $7, etc...

* `# snip` to indicate omitted output

There are 3485 lines in the data file. For most examples, I'll truncate the
output because more isn't always better.


## Always Use Single-Quotes with AWK

Let's get this out of the way: always use single-quotes with AWK.

As you've seen above, column names have dollar signs in them ($1, $2, $7...)
which would normally be substituted by BASH. Single-quotes are how you tell
BASH to keep the content of your strings untouched. Double-quotes won't work,
and backslash escapes _might_ work but are not worth fighting for.

Let's keep things **simple** with single-quotes.

If you need to inject some values into your script, I'll show you how in a
follow-up tutorial.


## What's With Those Curly Brackets? `{ }`

What's the difference between:

{% highlight bash %}
awk '{print $2}'

awk 'print $2'
{% endhighlight %}

Answer: one works and the other doesn't! ([rimshot](http://instantrimshot.com/))
We'll need to take a step back to explain the difference. In AWK, a program is
composed of _rules_ which look like:

{% highlight awk %}
some-condition { one or many statements }
{% endhighlight %}

If it were C code:

{% highlight c %}
if (some-condition) { one or many statements; }
{% endhighlight %}

In short, the curly brackets (`{ }`) tell AWK to _do_ something. AWK allows
either the condition or the action to be missing.


## What does it mean when the condition is missing?

A missing condition defaults to "always run":

{% highlight bash %}
awk '{print $2}'
# means:
awk '1 {print $2}'      # 0 is false, any other value is true
{% endhighlight %}

if true, print the 2nd column.

## What does it mean when the action is missing?

A missing action defaults to "print":

{% highlight txt %}
$ cat netflix.tsv | awk '$2 > 100'
Date        Open        High        Low         Close       Volume     Adj Close
2016-03-22  100.480003  101.519997  99.199997   99.839996   9039500    99.839996
2016-03-21  101.150002  102.099998  99.50       101.059998  9562900    101.059998
2016-03-18  100.50      102.410004  100.010002  101.120003  15437300   101.120003
2016-03-07  101.00      101.790001  95.25       95.489998   23855200   95.489998
2016-01-22  104.720001  104.989998  99.220001   100.720001  26772700   100.720001
# snip -- output has been reformated to align
{% endhighlight %}

A missing block just prints the whole matching line.

{% highlight bash %}
awk '$2 > 100'
# means:
awk '$2 > 100 { print }'
# means:
awk '$2 > 100 { print $0 }'
{% endhighlight %}

`$0` is a special variable that contains the current line, before it was
separated into fields. `print $0` means "print the current line". `print`, by
itself, also prints the current line.


## More Printing

You know how to print one column, but what if you need print many?

{% highlight txt %}
$ cat netflix.tsv | awk '{print $1, $6, $5}'
Date        Volume    Close
2016-03-24  10646900  98.360001
2016-03-23  8292300   99.589996
2016-03-22  9039500   99.839996
2016-03-21  9562900   101.059998
2016-03-18  15437300  101.120003
# snip -- output has been reformated to align
{% endhighlight %}

A comma between print values will insert a space in the output. AWK also has
`printf` which unleashes infinite [formatting power](http://linux.die.net/man/3/printf):

{% highlight txt %}
$ cat netflix.tsv | awk '{printf "%s %15s %.1f\n", $1, $6, $5}' | sed 1d
2016-03-24        10646900 98.4
2016-03-23         8292300 99.6
2016-03-22         9039500 99.8
2016-03-21         9562900 101.1
2016-03-18        15437300 101.1
# snip
{% endhighlight %}

I removed the header line, which had been mangled in the printf.

AWK does string concatenation without an operator: just put 2 values next to
each other. This is useful when you don't want to reach for printf but still want
some formatting flexibility:

{% highlight txt %}
$ cat netflix.tsv | awk '{print $1 "," $6}'
Date,Volume
2016-03-24,10646900
2016-03-23,8292300
2016-03-22,9039500
2016-03-21,9562900
2016-03-18,15437300
# snip
{% endhighlight %}

Ooooh, we're back to CSV.


## Taking inventory: what can you do?

This is just the beginning, and there's more to cover. But you now have a solid
foundation: you know about conditions and actions, columns and printing. You can:

* print only the columns you want
* print them in the order you want
* format with all the power of printf
* use conditions to print only lines you want


## Exercises

Try to:

* only print the 'Date', 'Volume', 'Open', 'Close' columns, in that order
* only print lines where the stock price increased ('Close' > 'Open')
* print the 'Date' column and the stock price difference ('Close' - 'Open')
* print an empty line between each line -- double-space the file

Answers are [here]({{site.url}}/assets/awk-tutorials/answers-part1.txt).

## What's next?

[Part 2](http://blog.jpalardy.com/posts/awk-tutorial-part-2/)

