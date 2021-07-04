---
layout: post
title: 'Elixir Notes: Mix Tasks and @shortdoc'
category: posts
---

I had not tried to write my own mix tasks until this week.
The [Mix.Task documentation](https://hexdocs.pm/mix/Mix.Task.html) made it look ridiculously easy:

![Mix.Task documentation screenshot](/assets/mix-tasks-shortdoc/mix-task.png)

In summary:
- create a file under `lib/tasks`
- `use Mix.Task`
- define a `run/1` function -- receives the command-line arguments (as a list of strings)

And... it worked. I felt [awesome](https://headrush.typepad.com/creating_passionate_users/2005/05/users_dont_care.html).

## A Small Problem

My new task didn't show up with the others in `mix help`. A quick search took
me, _ironically_, 3-4 paragraphs below the above screenshot, on the same page 😅

> Define the @shortdoc attribute if you wish to make the task publicly visible
> on mix help. Omit this attribute if you do not want your task to be listed
> via mix help.

Except ... that didn't work...

⚠️  note that `mix help` doesn't recompile the code ... try `mix compile` first, to ensure your changes show up.

## Deep Dive

I couldn't find a quick answer, so I cloned [the Elixir code](https://github.com/elixir-lang/elixir)
and started to grep.  
(specifically: `rg '[^@]shortdoc'`)

I found this:

![code that checks for @shortdoc](/assets/mix-tasks-shortdoc/build-task-doc-list.png)

As per line 178 (@ elixir 1.12), `Mix.Task.shortdoc(module)` is used to filter qualifying tasks. What did `iex` have to say about that?

![check in iex](/assets/mix-tasks-shortdoc/iex-check.png)

Hmmm... it works?! 🤔

It took _a lot_ more digging, but here's the complete picture:

[![complete code picture](/assets/mix-tasks-shortdoc/mystery-solved.png)](/assets/mix-tasks-shortdoc/mystery-solved.png)
(_click to enlarge_)

- yes, `@shortdoc` comes into play to filter the list, at #3
- but, before that, the listed tasks are filtered by `@moduledoc` also...

## Lessons Learned?

I found out about the behavior of `@moduledoc` before I found it in the code. That certainly _directed_ my search. The reasons that I kept digging:

- as always, I found the Elixir code to be approachable 💖
- I couldn't find _WHY_ the `@moduledoc` had to be present -- which seemed like a learning opportunity
- I couldn't find documentation that explicitly explained this behavior -- `@moduledoc` is said to provide the documentation printed by `mix help taskname`

