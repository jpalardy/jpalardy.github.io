---
layout: post
title: "ISO 8601 and Date Arithmetic on the Command-Line"
category: posts
---

## Why?

- typing full correct dates is painful
- date arithmetic is useful -- especially in bash scripts

## ISO 8601 Format

When you use `date`, you might not realize its full potential:

{% highlight bash %}
$ date
Mon Jan 15 18:43:31 PST 2018
{% endhighlight %}

it's better if you provide a format:

{% highlight bash %}
$ date +%Y-%m-%d                  # iso8601, of course
2018-01-15

$ date +%F                        # same: iso8601 has its own short format
2018-01-15
{% endhighlight %}

Check `man date` for all the formats you need. But why wouldn't you use
[ISO 8601](https://en.wikipedia.org/wiki/ISO_8601)?


## Specify an Absolute Date

You can specify a date to format with `-d`, it recognizes a bunch of formats:

{% highlight bash %}
$ date +%F -d 2018-02-25          # silly: iso8601 to iso8601...
2018-02-25

$ date +%F -d "February 25 2018"  # full date
2018-02-25

$ date +%F -d "Feb 25 2018"       # short month
2018-02-25

$ date +%F -d "Feb 25"            # missing year, current year implied
2018-02-25
{% endhighlight %}


## Specify a Relative Date

The `-d` flag also accepts relative dates:

{% highlight bash %}
$ date +%F -d "next Saturday"
2018-01-20

$ date +%F -d "next Sat"          # short day name
2018-01-20

$ date +%F -d "3 sat"             # 3 Saturdays from today
2018-02-03

$ date +%F -d "2 months"
2018-03-15

$ date +%F -d "3 weeks sat"       # Saturday after 3 weeks
2018-02-10

$ date +%F -d "last month"
2017-12-15

$ date +%F -d "-5 days"           # also: "5 days ago"
2018-01-10
{% endhighlight %}

The documentation says:

- "last" means -1
- "this" means 0
- "next" means 1
- "ago", as a suffix, means negative
- "now" and "today" mean 0

There is support for units (in singular and plural):

- year
- month
- week
- day
- hour
- min(ute)
- sec(ond)


## Date Arithmetic!

Yes, you can combine both absolute and relative dates:

{% highlight bash %}
$ date +%F -d "today + 3 days"
2018-01-18

$ date +%F -d "+ 3 days"          # shorter
2018-01-18

$ date +%F -d "3 days"            # shorter still
2018-01-18

$ date +%F -d "sep 1 - 3 weeks"
2018-08-11

$ date +%F -d "5 days - 3 weeks"
2017-12-30
{% endhighlight %}

Some of these are useful, others not so much... it depends what you need.

Think about your edge cases carefully:

{% highlight bash %}
$ date +%F -d "jan 27 + 1 month"
2018-02-27

$ date +%F -d "jan 28 + 1 month"
2018-02-28

$ date +%F -d "jan 29 + 1 month"  # careful!
2018-03-01

$ date +%F -d "feb 1 + 1 month"   # same...
2018-03-01

$ date +%F -d "jan 30 + 1 month"  # careful!
2018-03-02

$ date +%F -d "jan 31 + 1 month"  # careful!
2018-03-03
{% endhighlight %}

This [page](https://www.gnu.org/software/coreutils/manual/html_node/Relative-items-in-date-strings.html#Relative-items-in-date-strings) (bottom) discusses
this gotcha and possible workarounds.

The subpages of [Date input formats](https://www.gnu.org/software/coreutils/manual/html_node/Date-input-formats.html)
contain all the details from above, and more... For example, I didn't even try to discuss times, timezones and all their
terrifying complexity.


## My `iso8601` Helper

Because I use ISO 8601 dates in a bunch of command-line contexts, I wrote a [helper](https://github.com/jpalardy/dotfiles/blob/master/bin/iso8601).
Dump the script (call it `iso8601`) in your PATH:

{% highlight bash %}
#!/bin/bash

date +%F -d "$*"
{% endhighlight %}

The `$*` sequence means you don't need to (but still can) quote your inputs:

{% highlight bash %}
$ iso8601
2018-01-15

$ iso8601 3 days
2018-01-18

$ iso8601 mar 15
2018-03-15

$ iso8601 jun 6 + 3 weeks
2018-06-27

$ iso8601 "jun 6 + 3 weeks"       # use quotes, if you want...
2018-06-27
{% endhighlight %}

I use this script mainly from inside Vim. I type `!!iso8601 <bla bla>` on a blank line to insert a date.

