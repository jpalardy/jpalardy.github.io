---
layout: post
title: Awk Tutorial, part 3
category: posts
---

I [already mentioned](https://blog.jpalardy.com/posts/why-learn-awk/) why you should learn AWK.  
In [part 1](https://blog.jpalardy.com/posts/awk-tutorial-part-1/), we laid a _solid_ foundation.  
In [part 2](https://blog.jpalardy.com/posts/awk-tutorial-part-2/), we covered _most_ of what you would ever need.  
Let's cover what's left.


## Input Separators

How does AWK decide what a "column" is and isn't?

AWK "trims" the line and separates on adjacent whitespace: `\s+` as a regex.
That's _usually_ what you want, but you can specify what you need with the `-F`
option:

{% highlight txt %}
$ cat netflix.csv | awk -F, '{print $5}'     # split columns on commas
Close
98.360001
99.589996
99.839996
101.059998
101.120003
# snip
{% endhighlight %}

(source file: [netflix.csv](/assets/awk-tutorials/netflix.csv))

In reality, the `-F` option takes a regular expression:

{% highlight txt %}
$ cat netflix.csv | awk -F'[,-]' '{print $3, "--", $0}'
High -- Date,Open,High,Low,Close,Volume,Adj Close
24 -- 2016-03-24,98.639999,98.849998,97.07,98.360001,10646900,98.360001
23 -- 2016-03-23,99.75,100.389999,98.809998,99.589996,8292300,99.589996
22 -- 2016-03-22,100.480003,101.519997,99.199997,99.839996,9039500,99.839996
21 -- 2016-03-21,101.150002,102.099998,99.50,101.059998,9562900,101.059998
18 -- 2016-03-18,100.50,102.410004,100.010002,101.120003,15437300,101.120003
# snip
{% endhighlight %}

It separated on commas or hyphens, and picked the 3rd column (the day). This
can be a useful approach to extract subfields.

## Output Separators

When you use a comma (`,`) in a print statement, that means "space", right?  
By default, it does. But that's configurable:

{% highlight txt %}
$ cat netflix.tsv | awk '{print $1, $6}'                    # default: space
Date Volume
2016-03-24 10646900
2016-03-23 8292300
2016-03-22 9039500
2016-03-21 9562900
2016-03-18 15437300
# snip

$ cat netflix.tsv | awk 'BEGIN {OFS=","} {print $1, $6}'    # custom: comma
Date,Volume
2016-03-24,10646900
2016-03-23,8292300
2016-03-22,9039500
2016-03-21,9562900
2016-03-18,15437300
{% endhighlight %}

The OFS (Output Field Separator) variable controls what goes between each
field. I don't use it very much; I usually format the output
explicitly. But it's _sometimes_ useful, and it's good to know.


## Passing in Variables

As in the previous example, you could decide to initialize variables in the
`BEGIN` block. But that's not always possible -- the `BEGIN` block lives inside
the single-quotes which severely limits what you can do.

What if you want to pass in variables, maybe from a shell script?

{% highlight txt %}
$ cat netflix.tsv | awk -v col=6 '{print $col}'    # instead of hardcoding $6
Volume
10646900
8292300
9039500
9562900
# snip
{% endhighlight %}

The `-v` (mnemonic "var") option allows you to set variable from outside the
script, a convenient place where shell variables and substitutions are
available. We revisit the `OFS` variable from above, in the way I would prefer
to set it:

{% highlight txt %}
$ cat netflix.tsv | awk -v OFS=, '{print $1, $6}'
Date,Volume
2016-03-24,10646900
2016-03-23,8292300
2016-03-22,9039500
2016-03-21,9562900
2016-03-18,15437300
# snip
{% endhighlight %}


## Arrays

Imagine a programming language without arrays or dictionaries. That's how we've
been using AWK up until now. But everything truly clever you can do with AWK (or any programming language)
probably requires arrays.

AWK arrays are very similar to JavaScript arrays: they can serve both as
"regular" arrays (with number keys) or as dictionaries (with string keys).

How would we `SUM(volume) GROUP BY year`?

{% highlight txt %}
# warning -- scroll right...
$ cat netflix.csv | awk -F'[,-]' '{volume[$1] += $8} END { for(year in volume) print year, volume[year]}'
2009 2904000400
Date 0
2010 7126840000
2002 782530000
2011 11185849500
2003 4256021000
# snip
{% endhighlight %}

* split columns on commas or hyphens
* accumulate volume ($8) in a dictionary, using the year ($1) as key
* volume is a variable that gets created as a dictionary, because we use it as a dictionary -- this was discussed in [part 2](https://blog.jpalardy.com/posts/awk-tutorial-part-2/)
* at the END, print each year and volume sum

When working with arrays, this pattern of "accumulation" and "reporting" at the
END is commonplace. But there are some problems with the output, and they highlight
interesting points:

* the output isn't sorted, the for-loop makes no guarantee over the order of the keys
  _(that can be fixed with a trailing `sort -n`)_
* the header was considered as a key, "Date", and accumulated 0  
  _(that can be fixed by removing the first line before AWK (`sed 1d`) or by using_  
  _`NR > 1` before the accumulator block)_


## Longer Scripts

I've been selling AWK as a language optimized for one-liners, but it's possible
to reach unpleasant extremes. The last example wasn't too complicated, but it was
long. It could be made more readable.

It's possible to package multiple lines of AWK in a bash script:

{% highlight bash %}
#!/bin/bash

cat "$@" | awk -F'[,-]' '

{volume[$1] += $8}

END {
  for(year in volume) {
    print year, volume[year]
  }
}

'
{% endhighlight %}

* there's a shebang line, it's a bash script on the outside
* `cat "$@"` is a passthrough: if you feed a filename to the script, it will be used. If you don't, an empty `cat` won't hurt.  
  _(it allows you to call `SCRIPTNAME file` or `cat file | SCRIPTNAME`)_
* notice the trailing single-quote on the AWK line, that's where your script begins
* you can use multiple lines within the single-quotes
* use your own good taste to format the code
* notice the single-quote at the end, that's a good place to put a pipe (if you need it)

Now you can combine the best of bash scripting, with the power of AWK -- all in
a very portable package.


## Taking inventory: what can you do?

Everything I can.

Specifically, you have:

* more flexible ways to parse inputs with `-F`
* more convenient ways to print outputs with `OFS`
* ultimate programming power: arrays!
* a nice way to package your logic in a bash script


## Exercises

Try to:

* calculate the average closing price, grouped per year
* calculate the max closing price, grouped per month
* calculate the median volume, in 2015 -- you might need [this](https://www.gnu.org/software/gawk/manual/html_node/Array-Sorting-Functions.html#Array-Sorting-Functions)

Answers are [here](/assets/awk-tutorials/answers-part3.txt).

## What's next?

As a conclusion: [my best AWK tricks](https://blog.jpalardy.com/posts/my-best-awk-tricks/).

At this point, I hope they won't be a list of opaque incantations.  
You will be able to see _what_ and _how_ it's done.

