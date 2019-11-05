---
layout: post
title: "Up your Go Game with golangci-lint"
category: posts
---

## Another linter?

If you're working on Go projects, running
[golangci-lint](https://github.com/golangci/golangci-lint) is a no brainer. It
has helped me catch real problems on many different projects.

There are a lot of Go linters out there:

![Go linters supported by ALE]({{site.url}}/assets/golangci-lint/other-linters.png)

(_[source: ALE supported tools](https://github.com/dense-analysis/ale/blob/master/supported-tools.md)_)

but, in the tradition of
[gometalinter](https://github.com/alecthomas/gometalinter), golangci-lint runs
a bunch of other linters for you. Golangci-lint is convenience itself, you can skip:

- learning about
- reviewing
- installing
- configuring
- running

each linter separately.

## How to install it?

Installing golangci-lint can be as easy as:

{% highlight bash %}
> brew install golangci/tap/golangci-lint
{% endhighlight %}

(_see [here](https://github.com/golangci/golangci-lint#install) for alternative installations_)

## How to run it?

Go to the base directory of your project and run:

{% highlight bash %}
> golangci-lint run
{% endhighlight %}

and marvel at everything you're doing wrong 😃

I personally like to take it to the next level and run:

{% highlight bash %}
> golangci-lint run --enable-all
{% endhighlight %}

which runs _ALL_ the linters. Which linters are run by default?

![Golangci-lint default linters]({{site.url}}/assets/golangci-lint/default-linters.png)

(_also [here](https://github.com/golangci/golangci-lint#enabled-by-default-linters)_)

## It hurts!

<img class="img-right" style="width: 275px" src="{{site.url}}/assets/golangci-lint/chinese-proverb.png" alt="The best time to plant a tree..."/>

When is the best time to run a linter?

> back when you started your project...

The second best time is now.

Douglas Crockford [said it best](http://www.jslint.com/help.html#warning):

> JSLint will hurt your feelings.

which can be generalized to most linters. But, over time, using a linter makes
you internalize the rules. As you learn the rules, you learn to avoid breaking
them. Eventually, your project is clean and there's nothing to feel bad about.

However, in the meantime...

## Taking it one step at a time

If you're getting too many warnings, there are ways to cope. You can put a
config file (called `.golangci.yml`) at the base of your project. Here's mine,
for example:

{% highlight yaml %}
---
run:
  skip-dirs:
    - generated
linters:
  disable:
    - wsl
{% endhighlight %}

(_[all config options](https://github.com/golangci/golangci-lint#config-file)_)

Why?

- skip the `generated` directory: the code generator I use doesn't comply 😢
- `wsl` is a newer addition and I haven't had time to review its complaints (I'm only human)

That highlights a good-news/bad-news aspect of linters: they are moving
targets. When you update them, you get newer and better rules, but new "problems" might
be flagged in your previously clean project.

Use common sense to decide if/when you want to update your linter, and whether
the new rules make sense for your project (or go too far, for your liking, into crazy).
Linters are meant to cheaply catch problems, not just make you feel bad.

