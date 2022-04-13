---
layout: post
title: Parsing and Validating Dates in Awk
category: posts
---

I recently stumbled on something that I _thought_ would be easy: parsing and validating dates in Awk.

Some guidelines:
- [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format, e.g. `2022-04-12`
- months between 01 and 12
- days between 01 and 28-31 (depending on the month, leap year)

A quick lookup for GNU Awk's [time functions](https://www.gnu.org/software/gawk/manual/html_node/Time-Functions.html) points to `mktime("YYYY MM DD HH MM SS")`

Let's try it:

{% highlight bash %}
> echo "2022 04 12" | awk '{ print mktime($0 " 0 0 0") }'
1649746800

# removed hyphens for now, will fix in solution below
# padded HH MM SS with 0 0 0, to keep mktime happy
{% endhighlight %}

Looking good! How about something wrong?


{% highlight bash %}
> echo "not a date" | awk '{ print mktime($0 " 0 0 0") }'
-1
{% endhighlight %}

Oh yeah! What about a "bad" date?

{% highlight bash %}
> echo "2022 44 78" | awk '{ print mktime($0 " 0 0 0") }'
1760684400
{% endhighlight %}

Wait, what?! Oh no........

## Going Full Circle

If invalid dates returned -1, we would be done by now.

1760684400 is `2025-10-17` ... `mktime` takes 44 and 78 and (probably) multiplies those by seconds-per-month, and
seconds-per-day.

When I looked at the other [time functions](https://www.gnu.org/software/gawk/manual/html_node/Time-Functions.html),
there didn't seem to be anything that helped either.

The _eureka!_ was to think about using the invalid date to format a date back to ISO
8601 format. If the input and output dates are different, the date is wrong!

{% highlight bash %}
# good example
> echo "2022 04 12" | awk '{ d = mktime($0 " 0 0 0"); print strftime("%F", d) }'
2022-04-12
{% endhighlight %}

![parsing date and formatting the same date](/assets/awk-dates/date-roundtrip.png)

{% highlight bash %}
# bad example
> echo "2022 44 78" | awk '{ d = mktime($0 " 0 0 0"); print strftime("%F", d) }'
2025-10-17
{% endhighlight %}

Sidenote: I'm using `%F` to format dates. [man 3 strftime](https://man7.org/linux/man-pages/man3/strftime.3.html) says:

    %F     Equivalent to %Y-%m-%d (the ISO 8601 date format)

## Test Script

Here's my test cases:

{% highlight bash %}
> cat test.txt
2022-04-12 -- regular day
bad_date   -- not even a date
1981-11-20 -- 1980s
2022-44-78 -- nonsense month/day
2022-09-30 -- september has 30 days
2022-09-31 -- but not 31 ...
2016-02-28 -- leap year: february has 28 days
2016-02-29 -- leap year: even 29 days
2016-02-30 -- leap year: but not 30 days
2000-02-28 -- special leap year: february has 28 days
2000-02-29 -- special leap year: even 29 days
2000-02-30 -- special leap year: but not 30 days
2001-02-28 -- regular year: february has 28 days
2001-02-29 -- regular year: but not 29 days
2001-02-30 -- regular year: but not 30 days
1965-04-12 -- past, before 1970
1935-04-12 -- past, before 1970
{% endhighlight %}

The Awk script:

{% highlight bash %}
# hyphens now removed
> cat test.awk
{
  date = mktime(gensub("-", " ", "g", $1) " 0 0 0")
  if (strftime("%F", date) != $1) {
    print "bad: ", $0
    next
  }
  print "good:", $0
}
{% endhighlight %}

Results:

{% highlight bash %}
> awk -f test.awk test.txt                                                                                                                         ~/Documents/blog (main)
good: 2022-04-12 -- regular day
bad:  bad_date   -- not even a date
good: 1981-11-20 -- 1980s
bad:  2022-44-78 -- nonsense month/day
good: 2022-09-30 -- september has 30 days
bad:  2022-09-31 -- but not 31 ...
good: 2016-02-28 -- leap year: february has 28 days
good: 2016-02-29 -- leap year: even 29 days
bad:  2016-02-30 -- leap year: but not 30 days
good: 2000-02-28 -- special leap year: february has 28 days
good: 2000-02-29 -- special leap year: even 29 days
bad:  2000-02-30 -- special leap year: but not 30 days
good: 2001-02-28 -- regular year: february has 28 days
bad:  2001-02-29 -- regular year: but not 29 days
bad:  2001-02-30 -- regular year: but not 30 days
good: 1965-04-12 -- past, before 1970
good: 1935-04-12 -- past, before 1970
{% endhighlight %}

I was surprised that pre-1970 ([epoch](https://en.wikipedia.org/wiki/Unix_time)) also worked! Their `mktime` values are negative:

{% highlight bash %}
> echo "1935 04 12" | awk '{ print $0, "=>", mktime($0 " 0 0 0")}'
1935 04 12 => -1095782400

> echo "1969 12 31" | awk '{ print $0, "=>", mktime($0 " 0 0 0")}'
1969 12 31 => -57600

> echo "1970 01 01" | awk '{ print $0, "=>", mktime($0 " 0 0 0")}'
1970 01 01 => 28800
{% endhighlight %}

