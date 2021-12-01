---
layout: post
title: 'Software I like: Chrome Coverage Tab'
category: posts
---

[Azerbaijanian Translation](https://prodocs24.com/articles/chrome-coverage-tab/), thanks to Amir.

While both Chrome and Firefox have great developer tools; I had _almost_ forgotten
that Chrome has a [Coverage Tab](https://developer.chrome.com/docs/devtools/coverage/) ~ I hadn't needed it in a long time.

![coverage tab screenshot](/assets/like-coverage/coverage.webp)

It does both JavaScript and CSS; although I've only used the CSS part. For
JavaScript, it is often easier to instrument procedural code with
`console.log`.

## How to Use it?

I think the instructions in the [documentation](https://developer.chrome.com/docs/devtools/coverage/) (same link as above) are pretty good.

## My Experience

I recently inherited an application that someone else wrote. If CSS is hard to
understand, someone else's CSS can be a real challenge. This tweet felt
especially relevant:

![css is hell](/assets/like-coverage/css-on-fire.jpg)

With the coverage tab, you get an idea of what's used and what isn't:
- everything that's red is a candidate for deletion
- everything that's green is a candidate for replacement

One thing to keep in mind: the coverage tab is _dynamic_ ... something highlighted in red might turn green
when you navigate to different part of the page -- or when you activate it; either through hover, or some JavaScript action.

The coverage tab is more of a "guide" than a guarantee... Something green is definitely in use; while something red is not _currently_ used.

## Where is it?

It's not easily _discoverable_ -- If you don't know it's there, it's almost hopeless... (shame 😢)

Open `Developer Tools` and follow the clicks:

![finding the coverage tab in chrome](/assets/like-coverage/coverage-where.png)

(_sidenote: whoah... there's a lot more tools here than I expected_)


