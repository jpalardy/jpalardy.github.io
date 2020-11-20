---
layout: post
title: "JavaScript tooling: prettier"
category: posts
---

[Prettier](https://prettier.io/) is an awesome code formatter.

I was first exposed to code formatters when I was learning Golang. I thought
[gofmt](https://golang.org/cmd/gofmt/) was one of the most interesting aspects
of the language. Finally, we could all format our code the same way and skip
the endless discussions about style and where things should go. Prettier aims
to do the same for JavaScript, and a [bunch of other
languages](https://github.com/prettier/prettier#opinionated-code-formatter).

Prettier allows you to type messy code, press a key, and _probably_ get it in a
better shape than you would have done yourself.

Using their own example (but slightly shortened), you can transform:

{% highlight javascript %}
// from:

foo(reallyLongArg(), omgSoManyParameters(), IShouldRefactorThis());

// to:

foo(
  reallyLongArg(),
  omgSoManyParameters(),
  IShouldRefactorThis()
);
{% endhighlight %}

# Except when it doesn't... 

Prettier doesn't have too many [options](https://prettier.io/docs/en/options.html), and the idea of
configuring Prettier seems to go against the [philosophy](https://prettier.io/docs/en/option-philosophy.html) of the tool itself.

The setting that has the most significant impact on the final result is [printWidth](https://prettier.io/docs/en/options.html#print-width).
The documentation itself warns about setting the value too high:

> Prettier, on the other hand, strives to fit the most code into every line. With
> the print width set to 120, prettier may produce overly compact, or otherwise
> undesirable code.

`printWidth` defaults to 80, which felt claustrophobic... but higher values, ironically, will transform:

{% highlight javascript %}
// from:

foo(
  reallyLongArg(),
  omgSoManyParameters(),
  IShouldRefactorThis()
);

// back to:

foo(reallyLongArg(), omgSoManyParameters(), IShouldRefactorThis());
{% endhighlight %}

I found a _workaround_: if you add a single line comment, you force Prettier into a situation
where it cannot inline your code without getting rid of the comment (which it won't):

{% highlight javascript %}
// locked by the comment:

foo(
  reallyLongArg(), // ⏎
  omgSoManyParameters(),
  IShouldRefactorThis()
);
{% endhighlight %}

I use a ⏎ (Unicode character: [carriage return](https://en.wikipedia.org/wiki/Carriage_return)) as a convention in my own code, but what
you put in the comment is up to you.


# Prettier is not a linter

Prettier will fix the _format_ of your code, but it doesn't have opinions about
the _quality_ of your code.

For example, Prettier would not complain about:

- global or missing variables
- the use of `var` and other obsolete language features
- unused variables
- and other horrors...

([read more](https://prettier.io/docs/en/comparison.html))

Yes, you will probably still need [ESLint](https://eslint.org/). You will need to find a config that's compatible with Prettier's rules.
I use [airbnb-base](https://www.npmjs.com/package/eslint-config-airbnb-base) with some [tweaks](https://github.com/jpalardy/dotfiles/blob/056f78f561ebb71193751ef0499f82fa0364e3cf/eslintrc).
You can also check [Integrating with ESLint](https://prettier.io/docs/en/eslint.html).


# Getting Started

Check [Editor Integration](https://prettier.io/docs/en/editors.html) for details.

Most integrations have 2 modes:

- manual: a keyboard shortcut reformats the code
- automatic: saving a file reformats the code

Depending on the state of the codebase you're in, I find `manual`
mode makes more sense; I don't always want to reformat every file I touch.

