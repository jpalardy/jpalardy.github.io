---
layout: post
title: The World Changes Around Your Code
category: posts
---
It started with a conversation with my parents. We were talking about my work, legacy software and maintenance:

> But if that software is working ... why does it need maintenance?

At the time, I didn't have a ready-made answer.

- old software is crap?
- we do things differently now?
- things need to be updated?

## Why does software rot?

It is sometimes called [software rot](https://en.wikipedia.org/wiki/Software_rot) (or bit rot):

> [...] **a slow deterioration of software quality over time** or its diminishing
> responsiveness that will eventually lead to software becoming faulty,
> unusable, or in need of upgrade.

Further:

> This is not a physical phenomenon: **the software does not actually decay**, but
> rather suffers from a lack of being responsive and updated with respect to
> **the changing environment** in which it resides.

(emphasis mine)

In fact, you could argue that software rot is the opposite of regular rot: the
software is unchanged, but the **world itself** started to rot...

## No Software Is An Island...

Modern software rests on tremendous piles of dependencies:

- specific hardware
- operating systems
- libraries
- protocols
- conventions

Worse, your control over these things is limited (at best).

When — not if — these things change, you have 2 choices:

- keeping up — paying it down; incurring the cost
- punting — falling behind, revisiting this problem later... maybe?

## Technical Debt

I find it hard to talk about this problem without resorting to the language of economics.

People understand [technical debt](https://en.wikipedia.org/wiki/Technical_debt)
in the context of their own software: cutting corners _today_ for some benefit
— usually meeting a deadline. Some extra costs, or "interests" in this analogy,
are assumed under rework and future slowdowns.

_(in the context of this blog post, whether or not cutting corners will make things faster, or
ever be paid back is besides the point)_

In that sense, your dependencies are a type of technical debt — it's software
you didn't want to write and test. The hope is that the [total cost](https://en.wikipedia.org/wiki/Total_cost_of_ownership)
of your dependencies is lower than software you could write yourself.

In some cases, this is true! But it's certainly not true in all cases and
wisdom resides in knowing the difference (or hedging your bets).

