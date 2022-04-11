---
layout: post
title: Stop Typing Into REPLs
category: posts
---
## Help me help you

When I'm at someone's desks, in person or virtually, it drives me crazy to see
the _heroics_ of typing everything in a [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop)...

Let alone trying to manually fix broken code on in a REPL...

Or losing their work when exiting the REPL, and trying to grab fragments from the scrollback 😿

It doesn't have to be like this...

## REPLs aren't perfect...

I ❤️ REPLs and they have great features:

- interactivity (including control of evaluation and tab-completion)
- feedback speed

but they also have drawbacks, [YMMV](https://dictionary.cambridge.org/dictionary/english/ymmv):

- no syntax highlighting
- poor keyboard editing -- probably Emacs-style shortcuts
- poor history -- since session began; up/down arrow

Since text editors are becoming more interactive (i.e. like IDEs), and
computers are _generally_ becoming faster, the advantages of using a REPL have been
decreasing over time. It seems common to settle for "whatever, I'll just run
the code...".

But what if you could have both?

## Mixed mode environments

The most obvious example might be a [Jupyter notebook](https://jupyter.org/)

![screenshot of jupyter notebook](/assets/stop-typing-repls/jupyterlab.png)

You mix code cells and their results (whether text, number, graph) and weave,
step-by-step, a report/presentation. If you've ever used a Jupyter
notebook, or seen someone use one, you can see how powerful and liberating it
can be.

But, if you're willing to accept it, Microsoft Excel is probably the embodiment
of an interactive programming environment:

![screenshot of Excel](/assets/stop-typing-repls/excel.png)

> Excel formulas are the world's most widely used programming language.

-- [Microsoft, via The Register](https://www.theregister.com/2020/12/04/microsoft_excel_lambda/)

And while these environments might be blissful for specific tasks, they certainly are not general purpose...

## Turning EVERY REPL into a "Jupiter notebook"

We already have everything we need:

- a REPL -- any REPL will do
- a text editor

the REPL does what it's good for (interactivity, speed, ...) and the text editor can focus on its strengths:
- great editing
- syntax highlighting
- organising, formatting, saving text

What's missing? You need a way to "send text from the text editor to the REPL".

Good news if you're using vim, that's already available: [vim-slime](https://github.com/jpalardy/vim-slime)

![screenshot of vim-slime](/assets/stop-typing-repls/vim-slime.gif)

(disclosure: I am the author of vim-slime)

You end up with sessions that look like this:

![sample R session](/assets/stop-typing-repls/16-9.png)

- vim on one side
- R, or another REPL, on the other side
- graphs can pop in another window (this one opened by R)

I usually keep my eyes in vim, unless some error message shows up on the right.

## What do I use vim-slime for?

From memory, I've used vim-slime with:

- node (javascript)
- elm
- irb (ruby)
- python
- iex (elixir)
- R, R markdown
- octave
- mysql
- psql
- sqlite
- even shells! (fish, bash, zsh)

I haven't found a REPL where it wasn't advantageous to "wrap" in vim-slime.

## It doesn't have to be vim-slime...

I understand that vim isn't for everybody. The other good news is that vim-slime
isn't complicated ... most of the work happens when "shelling out". I don't see
why your favorite text editor couldn't support this type of workflow.

If you find compelling non-vim alternatives, email me and I'll include them on
this page for others to find.

