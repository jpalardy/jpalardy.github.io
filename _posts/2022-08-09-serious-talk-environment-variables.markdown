---
layout: post
title: 'Serious Talk: Environment Variables'
category: posts
---
## Not just JavaScript...

While this post uses `process.env` -- JavaScript, TypeScript, and node -- to make a point, none of the problems
listed are JavaScript-specific.

I've seen this done in almost every languages.

## The Setup

Using `process.env` is _sooooooo_ easy ... too easy:

{% highlight javascript %}
const databaseName = process.env.DATABASE_NAME;

// use databaseName to connect to a database?
{% endhighlight %}

What is wrong with this code?

## Problem 1: not _always_ a string

There's a definite "happy path" attitude to reaching into `process.env` and expecting a string. If you use TypeScript, the type hint
says:

    const databaseName: string | undefined

Correct: reaching for a non-existing environment variable gives you `undefined`.

What happens if `databaseName` is `undefined`? 🤔 That depends what you do with it. If your next line of code look like:

{% highlight javascript %}
const connection = await openConnection(databaseName); // and password, and...
{% endhighlight %}

then you're in trouble...

> just let it crash!

I don't disagree! If you always expect to run your application with all
(required) environment variables defined ... and missing variables will make it
crash... that's not bad. But propagating that `undefined` throughout your
application will probably not give you a great error message.

In TypeScript, you get a definite smell when you see:

{% highlight typescript %}
const databaseName = process.env.DATABASE_NAME as string;
// you "fixed" it, but I think TypeScript was trying to tell you something...
{% endhighlight %}

That `as string` is you saying "this will NEVER be undefined!"  

## Problem 2: maybe not a string either

Wait, what? What about this?

{% highlight typescript %}
const replicaCount = process.env.REPLICA_COUNT;
{% endhighlight %}

Oh no...

> use parseInt!

Indeed. But my greater point is that you are now "parsing" (it's in the name) a string. There are many way that can go wrong:

- not a number! e.g. `"MUFFIN", "eleven", "🐴", "INFINITY!"` ...
- not an integer! e.g. `3.3, 0.125, ½` ...
- not a positive integer! e.g. `-42, -1, -99999`
- or zero? `0`
- too big? `9999999999999`

At this point, you need to parse and you probably need to validate. That sounds like more code than a one-liner.

## Problem 3: it's easy to sprinkle around your project

In the end, maybe what you have is closer to:

{% highlight javascript %}
const databaseName = process.env.DATABASE_NAME || "aquarius";
{% endhighlight %}

- always a string
- a reasonable default
- no obvious validations: you will to take `DATABASE_NAME` as given  
(even if an empty/blank string?)

The problem is where this code lives... would you expect someone to `grep` your
project to find all environment variables? Finding a `process.env` in the
middle on some module makes me wonder what else is scattered all over the code.

Counterpoint: what if you tried to reach get `databaseName` from `process.argv`?

{% highlight javascript %}
// don't do this...
const databaseNameIndex = process.argv.indexOf("--database-name");
const databaseName = process.argv[databaseNameIndex + 1];
{% endhighlight %}

Would that deserve a comment in the code review?! In fact, it's hard to account for everything that's wrong with this approach... 😬 (make your own list!)

Why does `process.env` feel different than `process.argv`?

I think programmers understand that `process.argv` is a mess, in the best of
times. You cannot take anything for granted and handling it (correctly) is
enough work to justify bringing it a library.

But `process.env` _feels_ like a Dictionary of string to string. Maybe we
can skip all that gross work, cross our fingers, and, worst-case, let it crash?

I think that attitude accounts for the popularity of passing config through environment variables. (I know there are other reasons)

## What to do instead?

By now, I hope to have convinced you that config is complicated enough to handle separately and _seriously_.

My recommendations are:
- centralize ALL config in one place
- combine different sources -- config files, environment variables, command-line arguments, overriding in that order
- parse, validate, and sanity check early
- generate meaningful error messages
- let it crash, if appropriate

From the code that starts your app, you are aiming for:

{% highlight javascript %}
const config = getConfig();
// let getConfig crash or throw if something is wrong
{% endhighlight %}

and you can hide all that ugly and unexciting code in there.

If you get a `config` object, you can be sure that it contains everything you
need, that all its values have been validated (no nulls!). You can inject
`config` to everywhere it's needed ... and remove your guard clauses and
special cases.

It also makes mocking easier, no need to write to or modify `process.env` 😬
