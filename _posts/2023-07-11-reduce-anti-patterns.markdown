---
layout: post
title: Reduce Anti-Patterns
category: posts
date: 2023-07-11 20:37 -0500
---
I mentioned in [Reduce is Not the Answer](/posts/reduce-is-not-the-answer/) how:

- `reduce` is fairly low-level
- `reduce` doesn't capture "intent"

Very loosely, I believe that "loop constructs" fall somewhere on this abstraction scale:

[![loop abstraction scale](/assets/reduce-anti-patterns/loop-abstraction-scale.png)](/assets/reduce-anti-patterns/loop-abstraction-scale.png)

Exact placement is subjective; this is a starting point. As for `??` and beyond,
it might correspond to well-named functions with custom looping logic. For example, `mean` and `stdev` would
fit the bill. However, these function quickly become less generic.

If I missed something to the right, let's talk 😄

With this post, I want to sketch typical `reduce` patterns and identify their higher-level alternatives.

## Disclaimers

- Elixir is used; that should not stop anyone from understanding what's going on
- I'm aiming for _useful_, not _"revelation"_
- I put anchors ( 🔗 ) next to the section headers, copy-paste them as needed
- your code _might_ be an exception...

I initially added a comment to almost all sections:

> This is usually combined with other logic, to “save the extra loop”.

Yes, that's usually how it goes.

## Enum.map [🔗](#enummap-)

Usual shape:

{% highlight elixir %}
Enum.reduce(collection, [], fn item, acc ->
  [item.value | acc]
end)
|> Enum.reverse()
{% endhighlight %}

Giveaways:
- initial empty list
- item mapping or transformation
- prepend-reverse, or append

Alternative:

{% highlight elixir %}
Enum.map(collection, transformFun)
{% endhighlight %}

Comments:

Not often _directly_ found in the wild.

## Enum.filter / Enum.reject [🔗](#enumfilter--enumreject-)

Usual shape:

{% highlight elixir %}
Enum.reduce(collection, [], fn item, acc ->
  if condition do
    [item | acc]
  else
    acc
  end
end)
|> Enum.reverse()
{% endhighlight %}

Giveaways:
- initial empty list
- some conditional
- prepend-reverse, or append

Alternative:

{% highlight elixir %}
Enum.filter(collection, predicateFun)
# or, depending on the exact logic
Enum.reject(collection, predicateFun)
{% endhighlight %}

Comments:

_Probably_ combined with a `map`.

## Enum.find [🔗](#enumfind-)

Usual shape:

{% highlight elixir %}
Enum.reduce_while(collection, nil, fn item, acc ->
  if condition do
    {:halt, item}
  else
    {:cont, acc}
  end
end)
{% endhighlight %}

Giveaways:
- initial `nil` or sentinel value
- conditional; rest of loop doesn't matter...

Alternative:

{% highlight elixir %}
Enum.find(collection, transformFun)
{% endhighlight %}

Comments:

It might be driven by an edge case or custom logic.

## Enum.all? / Enum.any? [🔗](#enumall--enumany-)

Usual shape:

{% highlight elixir %}
Enum.reduce_while(collection, true, fn item, acc ->
  if condition do
    {:cont, acc}
  else
    {:halt, false}
  end
end)
{% endhighlight %}

Giveaways:
- initial flag
- conditional toggles a flag; rest of loop doesn't matter...

Alternative:

{% highlight elixir %}
Enum.all?(collection, predicateFun)
# or, depending on the exact logic
Enum.any?(collection, predicateFun)
{% endhighlight %}

Comments:

In some languages (e.g. JavaScript), this was be a later addition. It
also goes under various names (`some`, `every`...) and it might not be easy to
understand what it does and how/when to use it.

## Enum.count [🔗](#enumcount-)

Usual shape:

{% highlight elixir %}
Enum.reduce(collection, 0, fn item, acc ->
  if condition do
    acc + 1
  else
    acc
  end
end)
{% endhighlight %}

Giveaways:
- initial zero
- conditional math

Alternative:

{% highlight elixir %}
Enum.count(collection, predicateFun)
{% endhighlight %}

Comments:

This isn't always available; in that case, I would go for:

{% highlight elixir %}
Enum.filter(collection, predicateFun) |> length()
{% endhighlight %}

## Enum.sum [🔗](#enumsum-)

Usual shape:

{% highlight elixir %}
Enum.reduce(collection, 0, fn item, acc ->
  if condition do
    acc + item.value
  else
    acc
  end
end)
{% endhighlight %}

Giveaways:
- initial zero
- conditional math?
- value extraction/generation

Alternative:

{% highlight elixir %}
Enum.filter(collection, predicateFun) # if needed
|> Enum.map(transformFun)
|> Enum.sum()
{% endhighlight %}

## Enum.group_by / Enum.frequencies / Enum.split_with [🔗](#enumgroup_by--enumfrequencies--enumsplit_with-)

Usual shape:

{% highlight elixir %}
Enum.reduce(collection, %{}, fn item, acc ->
  key = fn.(item)
  if Map.has_key?(acc, key) do
    Map.put(acc, key, [item | Map.get(acc, key)])
  else
    Map.put(acc, key, [item])
  end
end)
{% endhighlight %}

Giveaways:
- initial empty map
- conditional update of map
- management of "not yet in map" edge case

Alternative:

{% highlight elixir %}
Enum.group_by(collection, keyFun)
# or, depending on the exact logic
Enum.frequencies(collection)
# or, depending on the exact logic
Enum.split_with(collection, predicateFun)
{% endhighlight %}

Comments:

This is all the same logic: divide things into groups.
- for `frequencies`, you only care about the size of the groups
- for `split_with` (often named `partition`), there are only 2 groups

## Enum.min / Enum.max [🔗](#enummin--enummax-)

Usual shape:

{% highlight elixir %}
Enum.reduce(collection, fn item, acc ->
  if item < acc do
    item
  else
    acc
  end
end)
{% endhighlight %}

Giveaways:
- initial sentinel value?
- conditional update

Alternative:

{% highlight elixir %}
Enum.min(collection)
# or, depending on the exact logic
Enum.max(collection)
{% endhighlight %}

## Discussion

Eventually, more languages and compilers will be able to grab a combination of
map-filter-etc and compile it down to one loop.

In the meantime, I'm afraid we will have to live with "optimized" one-loop `reduce`.

I'm always happy to discuss specific benchmarks regarding why your `reduce` can't
be a combination of `map`, `filter` and other `Enum` functions.


