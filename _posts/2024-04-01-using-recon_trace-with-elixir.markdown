---
layout: post
title: Using recon_trace with Elixir
category: posts
date: 2024-04-01 15:50 -0500
---
This year, I finally got around to learn [recon_trace](https://ferd.github.io/recon/recon_trace.html).

With this post, I intend to make your journey smoother and faster than mine.

## What is recon_trace?

In my own words:

> recon_trace allows you to attach an `IO.inspect` to any module/function in a running BEAM, without crashing it

Directly from the [documentation](https://ferd.github.io/recon/recon_trace.html):

> recon_trace is a module that handles tracing in a safe manner for single Erlang nodes, currently for function calls only.

## Why do I need recon_trace?

Is your production system behaving funny? Don't you wish you had just **a bit more** logging in a certain module?

With `recon_trace`, you can:

- see what functions are called, and how often
- see what arguments are passed to a function
- see what a function returns

And while you can't attach or log inside functions, it's a great alternative to having nothing.

## Installing recon

`recon_trace` is part of `recon`. It's an [hex package](https://hex.pm/packages/recon), so you already know what to do.

Something to keep in mind: adding `recon` to your project is "free", because it
doesn't run anything by default. It will sit there, waiting for you to call it
when you need it.

## A recon_trace cheat sheet

This is the template I use to get started:

{% highlight elixir %}
[
  {Module, :function, :return_trace}
]
|> :recon_trace.calls({100, 1000}, scope: :local)
{% endhighlight %}

And to turn off tracing:

{% highlight elixir %}
:recon_trace.clear
{% endhighlight %}

What makes `recon_trace.calls` complicated to explain is that [each argument is overloaded](https://ferd.github.io/recon/recon_trace.html#functions).

Let's take each argument, in reverse order: simplest to explain first.

## The 3rd argument: options

Straightforward: check [options](https://ferd.github.io/recon/recon_trace.html#t:options/0) to see everything that's available.

Buried in there, `scope: :local` which allows you to trace private functions. That's useful, so I use it by default.

## The 2nd argument: "max"

It's either a number: `n`

    only log `n` times

Or a rate: `{n, m}`

    only log `n` times per `m` milliseconds

I find the rate to be more flexible, so that's what I use by default. It keeps logging until I turn it off (or it goes above the rate limit).

## The 1st argument: a "spec"

This is something like an [MFA](https://elixirforum.com/t/documentation-of-what-an-mfa-is/25376/2).

- 1st: a module name, or `:_` for "any module"
- 2nd: a function name, or `:_` for "any function"
- 3rd: "arguments", which is either:
  - `:_` for "any arguments"
  - a number for a function with a specific arity
  - `:return_trace` (see below)
  - a [matchspec](https://www.erlang.org/doc/apps/erts/match_spec.html)
  - a lambda

`recon_trace` will [prevent you](https://github.com/ferd/recon/blob/master/src/recon_trace.erl#L486-L491) from doing something crazy like `{:_, :_, :_}`, which would log __everything__. This is what makes `recon_trace` safe.

For a default, I use `:return_trace` until I need something more specific.
It's a shortcut to log both the function call with its arguments and the
return value.

Note: `:return_trace` will log twice, and counts as `+2` towards your `max`.

## An Example

{% highlight elixir %}
[{Enum, :sort, :return_trace}]
|> :recon_trace.calls(10, scope: :local)
{% endhighlight %}

- what is using `Enum`?
- show me (exactly) `10` calls (because of `:return_trace`, 5 calls w/ 5 return values)
- include private functions (_which doesn't matter in this case_)

Annotated:

[![recon_trace demo](/assets/recon-trace/recon-demo.png)](/assets/recon-trace/recon-demo.png)
(click to enlarge)

`1` start iex for the "live" node

{% highlight elixir %}
iex --sname demo -S mix
{% endhighlight %}

`2` remote shell into it

{% highlight elixir %}
iex --remsh demo
{% endhighlight %}

`3` setup tracing

{% highlight elixir %}
[{Enum, :sort, :return_trace}] |> :recon_trace.calls(10, scope: :local)
{% endhighlight %}

What is that number `2` that's returned? That's the number of functions that
matched and are being traced. `0` usually means you did something wrong, while
other numbers might help in deciding whether you hit what you were targeting.

`4` trigger the relevant module/function

{% highlight elixir %}
1..10 |> Enum.shuffle() |> Enum.sort(:desc)
{% endhighlight %}

`5` observe 2 traces: the invocation and the return value

## Going Further

Though I've spent _some_ time with `:recon_trace`, I don't have all the answers.

Here are some resources to keep going:
- chapter 9 of [Stuff Goes Bad: Erlang in Anger](https://www.erlang-in-anger.com/)
  - Erlang-flavored, with some examples
- [recon_trace documentation](https://ferd.github.io/recon/recon_trace.html#content)
  - overlapping "Erlang in Anger", but more details in function signatures
  - the [examples](https://ferd.github.io/recon/recon_trace.html#calls/3) from `calls/3` function give you a good idea of what's possible
    - `'_'` in Erlang is the same as `:_` in Elixir
- the [code itself](https://github.com/ferd/recon/blob/master/src/recon_trace.erl)
  - the ultimate truth

