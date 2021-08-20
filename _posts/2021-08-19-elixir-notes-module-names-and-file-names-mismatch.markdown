---
layout: post
title: 'Elixir Notes: Module Names and File Names Mismatch'
category: posts
---

Short version: module names and file names don't have to match! There is a convention, but `mix` doesn't enforce it.

## Background

I became fully aware of this after I renamed a directory under `lib/`, but everything kept working...

This wasn't what I expected. I ran my tests _expecting_ to be told what I had broken.

At first, I thought it was a caching problem. I removed the
`_build` and `deps` directories and ... everything still worked!

## Why believe that names are important?

It was partly my experience with other languages. Coming from Go (or Java), we expect moving files around to break the build.

But, mostly, it was _BECAUSE_ most Elixir projects and examples are so
well-behaved! Inside a file named `lib/some/thing.ex`, we expect to find a module named `Some.Thing`.

![Elixir and Phoenix books](/assets/module-file-mismatch/elixir-books.png)

This naming is used consistently in all the Elixir and Phoenix books I read.

## It's a convention...

If you're feeling unsatisfied/surprised by this behavior, you're not alone. I found [a thread](https://elixirforum.com/t/module-naming-conventions/16636) by Joe Armstrong (no less!) discussing this. And here's the answer, from José Valim himself:

![Jose Valim's answer on ElixirForum](/assets/module-file-mismatch/jose-1.png)

Here's [another thread](https://elixirforum.com/t/module-naming-conventions-and-paths/1836) on the topic, and José's answer:

![Jose Valim's answer on ElixirForum](/assets/module-file-mismatch/jose-2.png)

Finally, here's the text from the [Naming Convention](https://hexdocs.pm/elixir/1.12/naming-conventions.html) reference:

{% highlight text %}
Generally speaking, filenames follow the snake_case convention of the module
they define. For example, MyApp should be defined inside the my_app.ex file.
However, this is only a convention. At the end of the day, any filename can
be used as they do not affect the compiled code in any way.
{% endhighlight %}

## Detour: a naming recipe

How to convert from a full path to a module name?

    e.g. lib/text_client/prompter.ex -> TextClient.Prompter

- start with a full path (dir + file name)
- remove the leading `lib/` or `test/` directory
- remove the extension
- capitalize each word
- replace `/` with `.`
- remove all `_`

## Implications

I read _"it doesn't matter"_ many times, but never understanding _EXACTLY_ what that meant in practice.

I ran a few experiments to convince myself of the behavior. Here's my new mental model:

- mix reads all `.ex` files under `lib/`, anywhere
- all these files _could be_ one big concatenated file
- all defined modules get compiled into their own `.beam` file

What does that imply?

__The name of a module and the file name where it is defined don't need to be related:__
- `Dog` module defined in `cat.ex`

__The directory structure doesn't matter:__
- `Animal.Mammal.Dog` module defined in `dog.ex`
- `Dog` module defined in `animal/mammal/dog.ex`

__Multiple modules can be defined in one file:__
- `Dog` and `Cat` modules both defined in `animals.ex`

__Combinations of the above:__
- `Animal.Mammal.Dog` and `Cat` modules both defined in `some/thing/unrelated.ex`

## Is this a good thing or a bad thing?

I was looking for understanding: what is allowed and not allowed. I had been working with Elixir for months
before _REALLY_ wondering how this worked... I had been following the naming convention and everything was great.

But [with great power comes great responsibility](https://en.wikipedia.org/wiki/With_great_power_comes_great_responsibility):
the naming convention exists so that we don't have to grep around all the time
-- use the convention, please. The alternative is complete chaos...

(that being said, there are times when it's useful to bend the rules)

Back to my original problem -- it would have been useful to "detect" that I had moved some files to a different directory and that _some_ renaming would be necessary to, once again, comply with the convention.

I wondered if there were tools to help catch this (and briefly considered writing my own). In the end, I found that [credo_naming](https://github.com/mirego/credo_naming) will detect exactly these types of mismatches.

