---
layout: post
title: "Problem Solving with MiniZinc"
category: posts
---

<a href="https://www.coursera.org/learn/modeling-discrete-optimization"><img style="float: right" src="/assets/minizinc-and-declarative-programming/modeling-discrete-optimization.png" alt="modeling and discrete optimization course banner" /></a>

It all started with this banner; a course recommendation on Coursera:

How can you say "no" to that? (_LEGO bricks!_)

This course turned out to be _brutal_. It advertised 5–10 hours/week of work
and might have **under**stated the case. (In my experience, online courses usually
**over**state the amount of work involved.)

Even though it was a hard class, I learned a lot. One of the
reviews says:

> Difficult but rewarding course.

and that's also how I would describe it.

This version of the course is a few years old, see [below](#how-to-get-started) for a newer version.


## MiniZinc

You can't teach programming without a programming language. Similarly, you
can't teach optimization modeling abstractly, you'll need a modeling language.

MiniZinc is the language you'll use to describe models. These models get
compiled and run on
[solvers](https://en.wikipedia.org/wiki/List_of_optimization_software). The solvers
will search through the problem space and generate possible solutions.

Let's go through an example.


## An example: The Change-making problem

From the [wikipedia page](https://en.wikipedia.org/wiki/Change-making_problem):

> how can a given amount of money be made with the least number of coins  
> of given denominations?

Specifically, in the US, a cashier would give back $0.78 as 3 quarters and 3 pennies.

**_BEFORE_** you grab that marker and head over to that whiteboard, let me stop you.  
I **_know_** that you know how to solve this: that's why I picked this problem.
And I'm going to explain why it's a bad idea for **_you_** to solve this problem.


## A solution

Using MiniZinc, I would try this:

![modeling and discrete optimization course banner](/assets/minizinc-and-declarative-programming/mzn-solution.png)

* line 2: the amount, in cents, hardcoded to $0.78
* line 3: US denominations, in cents
* line 5: an array of counts -- how many coins to use for each denomination
* line 9: **constraint**: the sum of the counts times the denominations _must_ add up to the amount
* line 11: the sum of the counts is the number of coins
* line 12: minimize the number of coins
* line 14-18: how to format the output

Run it:

{% highlight bash %}
$ minizinc change-making.mzn
coins  = 6;
denoms = [25, 10, 5, 1];
counts = [3, 0, 0, 3];
----------
==========
{% endhighlight %}

> NOTE: This program was simplified for the purpose of discussion -- I wouldn't normally hardcode everything. There are ways to
> separate your model from your data, and/or to pass arguments from the command-line.


## So what?

MiniZinc code is declarative -- you're not telling it _how_ to solve the problem, you're just telling it what the problem is:

* what is constant (amount, denominations)
* what is variable (counts)
* what constraints we have
* what to optimize

If you're still not convinced, let me [hold your beer](https://www.urbandictionary.com/define.php?term=hold+my+beer)
while you think of _your own_ solution and think how you would integrate the
following constraints without having to rewrite -- or worse: completely re-think --
the whole problem:  
(_let alone doing it in 1 or 2 lines of code_)

Is there a solution with 8 coins?

{% highlight text %}
constraint coins = 8;
# coins  = 8;
# denoms = [25, 10, 5, 1];
# counts = [2, 2, 1, 3];
{% endhighlight %}

What's the best solution without quarters?

{% highlight text %}
constraint counts[1] = 0;
# coins  = 11;
# denoms = [25, 10, 5, 1];
# counts = [0, 7, 1, 3];
{% endhighlight %}

What's the best solution using exactly 3 nickels?

{% highlight text %}
constraint counts[3] = 3;
# coins  = 9;
# denoms = [25, 10, 5, 1];
# counts = [2, 1, 3, 3];
{% endhighlight %}

Is there a solution where we give a different number for each coin? (but at least one)

{% highlight text %}
constraint alldifferent(counts);
constraint forall(i in 1..4) ( counts[i] >= 1 );
# coins  = 10;
# denoms = [25, 10, 5, 1];
# counts = [1, 4, 2, 3];
{% endhighlight %}

What if we don't use pennies?

{% highlight text %}
constraint counts[4] = 0;
# =====UNSATISFIABLE=====
{% endhighlight %}

Right, because sometimes there are no solutions satisfying all the constraints.


## Stand on the shoulders of giants

What you write in MiniZinc gets compiled down to a format that solvers can run.
This happens for the same reasons you don't usually write software in assembly:

* you can keep your solution at a higher-level
* you can keep your solution more portable -- you can run it against different solvers that expect different inputs
* certain optimizations can be done by the "compiler"

Solvers are magnificent beasts. They combine the insights of many researchers
who have dedicated their lives to finding better ways to run certain algorithms
(and other time-saving shortcuts). For example: if you can point out to the
solver that your problem is a variation of the [Knapsack problem](https://en.wikipedia.org/wiki/Knapsack_problem),
you'll often get answers orders of magnitude faster than you would otherwise.

Don't reinvent the wheel: determine that you need a wheel, and use one that's
been designed by a pro.


## How to get started?

MiniZinc has its own
[website](http://www.minizinc.org/),
[tutorial](http://www.minizinc.org/tutorial/minizinc-tute.pdf) and
[documentation](http://www.minizinc.org/doc-lib/doc.html).
But I can't say that I find them to be great resources -- not until you're
already familiar with the content.

I recommend the updated courses on Coursera:

<a href="https://www.coursera.org/learn/basic-modeling"><img style="float: left" src="/assets/minizinc-and-declarative-programming/basic-modeling.png" alt="basic modeling for discrete optimization course banner" /></a>

<a href="https://www.coursera.org/learn/advanced-modeling"><img style="float: left" src="/assets/minizinc-and-declarative-programming/advanced-modeling.png" alt="advanced modeling for discrete optimization course banner" /></a>

<br style="clear: both"/>

Write less code and solve harder problems.

If you think that solving sudoku takes more than a few lines of code, or a few minutes, you're working too hard.

