---
layout: post
title: "Reject Summary Statistics"
category: posts
---

A summary statistic is what you get when you reduce a bunch of numbers down to a single number:

{% highlight r %}
# the heights of 10 people you know (cm):
180 175 165 176 183 173 186 175 180 181

# the "average" of those heights:
177.4
{% endhighlight %}

But it doesn't have to be the *mean*, it could be:

* median / percentile / IQR
* mode
* min / max / range
* variance / standard deviation
* etc...

[Wikipedia](https://en.wikipedia.org/wiki/Summary_statistics) says:

> [...] summary statistics are used to summarize a set of observations, in order to communicate the largest amount of information as simply as possible.

## Why are summary statistics bad?

Summary statistics are extremely [lossy](https://en.wikipedia.org/wiki/Lossy_compression).

They take _all_ the data -- full of nuances, patterns, outliers, and special cases -- and
collapse it down to a single point.

What if the people you know included a basketball player?

{% highlight r %}
# the heights of 10 people you know (cm):
180 175 165 176 183 173 198 175 180 181
#                       ^^^              ... changed 1 value

# the "average" of those heights:
178.6
{% endhighlight %}

Yes: `178.6` is bigger than `177.4` ... but it doesn't begin to tell the real story:

![plot of heights](/assets/reject-summary-statistics/whoah.png)


## If you don't look at the data, you don't understand the data...

It's almost a cliché, but [Anscombe's quartet](https://en.wikipedia.org/wiki/Anscombe%27s_quartet) clearly shows
the limits of summary statistics:

![Anscombe's quartet](/assets/reject-summary-statistics/anscombes-quartet.png)

Those four data sets have the same:

* mean (both x and y)
* variance (both x and y)
* correlation
* linear regression

A more recent and striking example is the [datasaurus dozen](http://blog.revolutionanalytics.com/2017/05/the-datasaurus-dozen.html):

![datasaurus data set](/assets/reject-summary-statistics/datasaurus.gif)


## A terrible example: "average" request duration

If you've ever been asked:

> What's the average request duration?

for an HTTP endpoint, you know there's only one good answer:

> urgh...

The truth is that "it's complicated" and the question itself is based on many wrong assumptions:

* the distribution is [normal](https://en.wikipedia.org/wiki/Normal_distribution) ... it's [not](https://stats.stackexchange.com/questions/25709/what-distribution-is-most-commonly-used-to-model-server-response-time)
* the distribution has [one mode](https://en.wikipedia.org/wiki/Unimodality) ... probably [not](https://en.wikipedia.org/wiki/Multimodal_distribution), depending on caching, or the specific if-then-else handling, etc...
* the mean is "exact" ... rather than using a confidence interval

Here is a real duration graph distribution:

![sample durations distribution](/assets/reject-summary-statistics/density-durations.png)

Details:

* this is a [density](http://ggplot2.tidyverse.org/reference/geom_density.html) plot, a "smoothed" histogram
* yes, this is from a real production system
* it spans thousands of requests over a 1-hour window
* durations were cropped <= 250ms
* the mean duration is 62.4ms (56ms for the cropped data) -- [raw data](/assets/reject-summary-statistics/duration.csv)

The mean duration sits exactly **nowhere** interesting or representative.


## A failure of communication

Every time I hear/read the word "average", I assume the worst. The average, or
any summary statistics, obscures the real data, incompetently at best or maliciously
at worst.

Summary statistics _feel_ like information, but they are usually sound bites.

As a society, we need to strive for facts, for understanding, and for objective data:

* REJECT summary statistics: ask for the data if it's missing
* refuse conclusions until the data and methodology are produced and reviewed
* raise the bar: ask for visualizations -- but visualizations do NOT replace the data, they complement the data

