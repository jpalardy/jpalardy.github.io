---
layout: post
title: "One-liners to Remove Empty Lines from Text Files"
category: posts
---

There are multiple scenarios where removing empty lines might be necessary:

- reformatting source code
- cleaning up some data
- simplifying command-line output
- ...

but what's the easiest way of automating this?

## Aside: What is an empty line?

For the sake of this post, I'll make a distinction between "empty" and
"blank" lines:

* empty line: contains no characters at all
* blank line: might contain whitespace (spaces, tabs, nbsp, [etc...](https://en.wikipedia.org/wiki/Whitespace_character))

Blank lines _usually_ don't have a different meaning than empty lines.
Converting blank lines into empty lines makes subsequent handling simpler; it
normalizes your file and transforms 2 cases into just one.

{% highlight bash %}
# replace lines with only whitespace with "nothing"
> sed -E -e 's/^\s+$//' FILENAME
{% endhighlight %}

In turn, a blank line is just a special case of a line with trailing
whitespace. Trailing whitespace can be fixed:

{% highlight bash %}
# replace end-of-line whitespace with "nothing"
> sed -E -e 's/\s+$//' FILENAME
{% endhighlight %}

(Use the `sed` flag `-i`/`--in-place` as needed, but responsibly)

## How to remove all empty lines?

The easiest thing to type is `grep .`:

{% highlight bash %}
> cat sample.txt
3
4

5
6
7

8
9


10
11
12
13
14

> cat sample.txt | grep .
3
4
5
6
7
8
9
10
11
12
13
14
{% endhighlight %}

The dot (`.`) matches _any_ character ... but empty lines, by definition, do not contain
anything.

Another solution, for [awk enthusiasts](/posts/why-learn-awk/):

{% highlight bash %}
> cat sample.txt | awk NF
3
4
5
6
7
8
9
10
11
12
13
14
{% endhighlight %}

which has the added advantage of dealing uniformly with both empty and blank
lines. `NF`, or "number of fields", is non-zero (i.e. true), for lines containing non-whitespace characters.

## How to collapse multiple empty lines?

Empty lines have their uses: they separate paragraphs. But is there a difference
between one empty line and multiple empty lines? Probably not ... in most cases, multiple empty lines are redundant.

Although I could think of multiple ways to automate this (most of them involving AWK), I didn't have a quick one-liner until recently:

{% highlight bash %}
> cat sample.txt | uniq
3
4

5
6
7

8
9

10
11
12
13
14
{% endhighlight %}

It dawned on me that, in most text files, two identical lines following each other would not occur (or would be a mistake). But repeated empty lines fit that definition.

Is it cheating? Does it work as a side-effect? Maybe 😃

I haven't had a case _yet_ where it removed duplicate non-empty lines that I needed. (and if it did, I would be a short git command away from undoing it)

Did I miss anything? Is there a better-and-easier way to handle this?

