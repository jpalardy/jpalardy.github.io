---
layout: post
title: Gleam Support in Vim with ALE
category: posts
date: 2024-02-11 17:36 -0600
---
## Background

Over Christmas, I decided that it was a good time to try the [Gleam track on
Exercism](https://exercism.org/tracks/gleam). I prefer to start without doing
too much research. Once the Exercism executable creates its directories and
stub files, that's when I start looking at tooling.

For me, it starts with Vim: no highlighting, but that wasn't too surprising
-- it's early days for Gleam. It wasn't hard to find [Gleam syntax
highlighting](https://github.com/gleam-lang/gleam.vim). It comes straight
from the [gleam-lang](https://github.com/gleam-lang) account, so that looks pretty solid.

## Can we do better?

Yes, with [ALE](https://github.com/dense-analysis/ale).

When I ran `:ALEInfo`, I could _NOT_ find any Gleam support. I had to double-check
against the [list of supported tools](https://github.com/dense-analysis/ale/blob/master/supported-tools.md).

Usually, I'm not such an early adopter.  
Usually, ALE is ahead of my needs

Until now.

## Gleam Tooling

Running `gleam --help` shows that it has both a `format` command and a [language server](https://en.wikipedia.org/wiki/Language_Server_Protocol)!

[![gleam --help has LSP and format built-in](/assets/gleam-in-vim/gleam-help.png)](/assets/gleam-in-vim/gleam-help.png)

How hard could this be?

## ALE Support for Gleam

Good news:

- PR: [LSP support](https://github.com/dense-analysis/ale/pull/4696)
- PR: [format support](https://github.com/dense-analysis/ale/pull/4710)

and both have been merged ✅

[![gleam is now part of ALE](/assets/gleam-in-vim/gleam-support.png)](/assets/gleam-in-vim/gleam-support.png)

Make sure to update your ALE plugin to the latest version and enjoy 😄

