---
layout: post
title: My Best Awk Tricks
category: posts
---

This is a wrap-up of my AWK tutorial series.  
You can start with [why learn awk](https://blog.jpalardy.com/posts/why-learn-awk/).  
Or you can jump straight to [part 1](https://blog.jpalardy.com/posts/awk-tutorial-part-1/) of the tutorial.

If you've read the tutorial, the amount of _magic_ should be down to a minimum.


## Disclaimers

Before you ask: I have a cheatsheet, and that's where I keep the recipes that
follow. I'm just human -- I copy and paste what I need.

I'm not the author of these recipes; I only collected them over time.

Allow me to skip the `cat FILE |` or `awk 'YOUR SCRIPT' FILE` parts. By now,
I trust you to figure that out.

Which specific columns make sense for your specific needs will depend on you.
I might use `$0` or `$1`, but you'll have to fix those. That's what I do after I paste.


## uniq without sort

I posted about this [before](https://blog.jpalardy.com/posts/unsorted-uniq/), but it's still my favorite:

{% highlight bash %}
$ awk '!seen[$0]++'
{% endhighlight %}

The action is `print`, of course. The condition is _true_ the first time a
string is put into the array. It follows that subsequent appearances won't be
printed.

Related to the above, print duplicates (without sort):

{% highlight bash %}
$ awk '++seen[$0] == 2'
{% endhighlight %}

Print the 2nd time you see a string.


## Group counts or sums

This was covered in the tutorial, but it's damn useful:

{% highlight bash %}
$ awk '{ groups[$0]++ }     END { for (k in groups) print groups[k], k }' # count
$ awk '{ groups[$1] += $2 } END { for (k in groups) print groups[k], k }' # sum
{% endhighlight %}

Accumulate in an array, report at the `END`. In both cases, pay attention to the columns you use.


## Set operations: union, intersection, difference

If you have multiple files, and you consider their content as sets, you can generate
a bunch of interesting subsets.

### Union

`cat` all the files and use the "uniq without sort" recipe from above :-)

### Intersection

For both intersection and difference, you need to accumulate from one file and
process the other file.

{% highlight bash %}
$ awk 'NR == FNR {lut[$0] = 1; next} $0 in lut {print}' FILE1 FILE2
{% endhighlight %}

The main trick is to realize that `NR` and `FNR` will, by definition, only be equal
during the processing of the first file. The `next` statement ensures the rest
of the one-liner is skipped. We load the lut (LookUp Table) array with the relevant
parts from the first file.

Why use `$0 in lut` instead of `lut[$0]` for the condition? That's an
optimization I learned the hard way: even a _miss_ lookup in `lut[$0]` will
instantiate the array location to an empty string -- and over the processing of
HUGE files, you'll eventually consume a lot of memory.

*It takes a LOT for this problem to **be** a problem with the amount of memory
that computers have nowadays ... that's why I didn't cover the `in` operator in
the tutorial.*

### Difference

{% highlight bash %}
$ awk 'NR == FNR {lut[$0] = 1; next} !($0 in lut) {print}' FILE1 FILE2
{% endhighlight %}

This operation isn't symmetrical: you're removing the entries from FILE1 from
FILE2. Switch the files around to get the other set difference.


## Easy performance

If your AWK script isn't fast enough, it might be time to consider whether AWK
is the right tool for the job. How many GB of data are you piping through it?!

That being said, I know 2 tricks to speed up AWK:

### Drop unicode support

{% highlight bash %}
$ LC_ALL=C awk 'YOUR SCRIPT'
{% endhighlight %}

The `LC_ALL` variable forced to C will drop unicode support and, sometimes, greatly
speed up processing.


### Use mawk

There are many variants of AWK, and the one you're using is _probably_ GNU AWK.  
There are others: [mawk](https://invisible-island.net/mawk/) is one of the
FAST one.

* is mawk already installed?
* how much of a pain will it be to install?
* will my AWK script work without modifications?

These are all good questions. In all likelihood:

* mawk won't be installed...
* it will be easy to install (`brew install mawk`, for example)
* your _unmodified_ AWK script will just run FASTER

If you're hitting the performance wall, giving mawk a chance might be worth it.

