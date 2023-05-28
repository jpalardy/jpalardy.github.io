---
layout: post
title: Reduce is Not the Answer
category: posts
date: 2023-05-28 14:27 -0500
---
## TLDR

The `reduce` function:
- can do _anything_, and often does...
- fails to communicate intent compared to its alternatives

`reduce` is the for-loop of functional programming...

## What is reduce?

The [reduce](https://en.wikipedia.org/wiki/Fold_(higher-order_function))
function takes a collection, iterates over it, and generates a single value.

Depending on the language, it might also be called: **fold**, **accumulate**, **aggregate**, **compress**, or **inject**.

{% highlight js %}
// a quick JavaScript example
> [1, 2, 3, 4, 5].reduce((acc, x) => acc + x);
15
{% endhighlight %}

If you're not already familiar with `reduce`, let me [punt to Google](https://www.google.com/search?q=reduce+function+explained).

## What's the problem?

`reduce` is just a for-loop, with some "accumulator". When the accumulator is a list/map, things can get complicated pretty fast.

Here's a for-loop:

{% highlight js %}
function doSomething(arr) {
  let acc = [];

  for (let value of arr) {
    // complicated code
  }

  return acc;
}
{% endhighlight %}

And here's the same code as a `reduce`:

{% highlight js %}
function doSomething(arr) {
  return arr.reduce((acc, value) => {
    // complicated code
  }, []);
}
{% endhighlight %}


What _COULD_ this code do? 🤔

Anything, really.

It could be a `map` or a `filter`, or some terrible combination of both or neither.

## My Point: reduce is too low-level

A for-loop can do anything and `reduce` has the same lack of clarity and intent... because it is a
[building block](https://hexdocs.pm/elixir/Enum.html#reduce/3-reduce-as-a-building-block):

> Reduce (sometimes called fold) is a basic building block in functional
> programming. Almost all of the functions in the Enum module can be
> implemented on top of reduce. [^1]

But a pile of building materials is not a house.

A `reduce`, given an anonymous function, is similar to tricky, inlined, and uncommented code.
It's a missed opportunity to extract that logic to a function and give it a name.

But first...

## Alternatives

That `reduce` is _probably_ not a special case, and it's _probably_ one of these:

- [map](https://hexdocs.pm/elixir/Enum.html#map/2)
- [filter](https://hexdocs.pm/elixir/Enum.html#filter/2)
- [any?](https://hexdocs.pm/elixir/Enum.html#any?/2), [all?](https://hexdocs.pm/elixir/Enum.html#all?/2)
- [count?](https://hexdocs.pm/elixir/Enum.html#count/2)
- [min](https://hexdocs.pm/elixir/Enum.html#min/3), [max](https://hexdocs.pm/elixir/Enum.html#max/3)
- [sum](https://hexdocs.pm/elixir/Enum.html#sum/1), [product](https://hexdocs.pm/elixir/Enum.html#product/1)
- [group_by](https://hexdocs.pm/elixir/Enum.html#group_by/3), [frequencies](https://hexdocs.pm/elixir/Enum.html#frequencies/1)

If you use a functional language [^2], refer to its excellent "enumerable" module:

- [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)
- [Ruby](https://ruby-doc.org/core/Enumerable.html)
- [Elixir](https://hexdocs.pm/elixir/Enum.html)
- [Elm](https://package.elm-lang.org/packages/elm/core/latest/List)

## What's Next?

In my next post [^3], I'm going to cover `reduce` anti-patterns.

<hr>

[^1]: This is a typical homework assignment.
[^2]: If missing, email me your own language's link
[^3]: Coming soon...

