---
layout: post
title: 'Livebook: Getting Started'
category: posts
---
## What is Livebook?

The easiest way to explain [Livebook](https://livebook.dev/) is to say it's [Jupyter notebook](https://jupyter.org/) for [Elixir](https://elixir-lang.org/).

Another way? What if Word and Excel had a baby?
- combine text
- and formula (or code)
- see the results
- in a cohesive document

[![screenshot of a livebook](/assets/livebook-getting-started/small-livebook-annotated.png)](/assets/livebook-getting-started/small-livebook-annotated.png)

## Why Livebook?

As an Elixir developer, I didn't really understand where Livebook was supposed to fit. After all, I already knew how to start a new project, or launch iex (Elixir's REPL).

What I found:
- it's so easy to get started -- more below -- for small to medium experiments  
  (as far as [The Advent of Code](https://adventofcode.com/), if you wanted -- [watch José Valim attempt 2021's](https://www.youtube.com/playlist?list=PLNP8vc86_-SOV1ZEvX_q9BLYWL586zWnF))
- it's more approachable for your colleagues -- _especially_ the less technical ones  
  (comparable to Excel, if they feel comfortable with that)

Maybe it fits a middle ground between throw-away script and new GitHub project 🤔

Last, but not least, with syntax coloring, code completion, and code formatting, it's a surprisingly good coding environment:

[![features mentioned above, visually](/assets/livebook-getting-started/features.png)](/assets/livebook-getting-started/features.png)

Let's get you started.

## How to Install?

- google: [livebook](https://www.google.com/search?q=livebook)
- click on the first page
- click "Install Livebook"
- download the app
- install like any other app

[![steps above, visually](/assets/livebook-getting-started/install-livebook-summary.png)](/assets/livebook-getting-started/install-livebook-summary.png)

What did you just install?
- a very recent version of Erlang and Elixir
- Livebook, the "app"

Livebook runs in your browser -- but the supporting code is what you installed.

There are [other ways to install](https://github.com/livebook-dev/livebook#installation), but I wouldn't recommend them unless you have very specific needs.

## How NOT to Run Livebook...

Of course, you _COULD_ just double-click the Livebook icon. Personally, I found that confusing (especially when I was getting started)

[![what Livebook looks like, when you first open it](/assets/livebook-getting-started/default-start.png)](/assets/livebook-getting-started/default-start.png)

What is all this? How do I start to code?  
(let's come back to this page [later](#wheres-the-documentation))

## How to Run Livebook: What I Recommend Instead

If you have some Livebook files already:
- open that folder
- double-click a Livebook file

[![a folder with some Livebook files](/assets/livebook-getting-started/folder-with-livebooks.png)](/assets/livebook-getting-started/folder-with-livebooks.png)

If you don't have Livebook files ready to go: know that an empty file is a completely valid Livebook file! 😄

{% highlight bash %}
> touch first.livebook
> open first.livebook      # open, on macos, is like double-clicking...
{% endhighlight %}

[![what an empty Livebook looks like](/assets/livebook-getting-started/empty-notebook.png)](/assets/livebook-getting-started/empty-notebook.png)

Starting from a file has a few advantages:
- less magic: you know where you files are
- Livebook starts in the right directory -- no need to navigate your file system from the browser...
- your file will start to autosave as you modify it

## What Now?

To get an idea, you can watch the "Announcing Livebook" video

<iframe width="560" height="315" src="https://www.youtube.com/embed/RKvqc-UEe34" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

<br/>
Another perspective is the one I linked above, solving Advent of Code with Elixir:

<iframe width="560" height="315" src="https://www.youtube.com/embed/mDxJjqx5-ns" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

## Where's the Documentation?

When I started out, I was really confused: where's the documentation?!

The [Livebook website](https://livebook.dev/) feels like a sales pitch ... no documentation? 🤔

Fortunately (or unfortunately), the Livebook documentation is found ... inside Livebook. (and if it's somewhere else, I haven't found it)

Let's loop back to what you see if you just open Livebook (without a file).

[![what Livebook looks like, when you first open it](/assets/livebook-getting-started/default-start.png)](/assets/livebook-getting-started/default-start.png)

If you click "Learn" on the left, or "LEARN -- see all >" in the middle, you will end up on this page:

[![the documentation page is found](/assets/livebook-getting-started/learn.png)](/assets/livebook-getting-started/learn.png)

If you click on one of the cards, it will open a Livebook to explain some aspect of Livebook (insert [Inception](https://www.imdb.com/title/tt1375666/) reference)

I strongly recommend the one called "Welcome to Livebook" (click the blue button, seen in the screenshot above). That Livebook does a good job getting you
to 80-90% of what you need to know.

## Conclusions

Using Livebook is a real pleasure, and I regret waiting so long to install and play with it.

Even using it a little bit allows you to really "get it".

Whether this is your way to get started with Elixir, or you're a veteran, Livebook has something to offer 🔥

(if not, it's also easy to uninstall 😜)

