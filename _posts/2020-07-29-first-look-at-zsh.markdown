---
layout: post
title: First Look at Zsh
category: posts
---

I had heard about [Zsh](https://en.wikipedia.org/wiki/Z_shell)
before: I thought it had many good things going for itself.
But... is it enough to switch shells?!

I spent years [reading](https://www.amazon.com/dp/0596009658/) about,
[studying](https://www.tldp.org/LDP/abs/html/index.html), often [writing](https://blog.jpalardy.com/) about Bash.
I didn't feel like Bash was holding me back. 😐

When Apple announced (2019) that Catalina would use Zsh as the default login
shell... I thought it might be time to, at least, do some due diligence on Zsh.

## It Starts with a Book

<a href="https://www.amazon.com/dp/1590593766/"><img class="book-cover" src="/assets/first-look-zsh/from-bash-to-z-shell.jpg" alt="book cover of From Bash to Z Shell" /></a>

On most systems, you can type `zsh` and get started ... but that doesn't mean
you're done. Few things will make you feel as incompetent as switching tools
unprepared: the jump into the unknown, the loss of muscle memory, all the
memorized trivia...

How does one get started with a new shell? Maybe reading [the manual](http://zsh.sourceforge.net/Doc/Release/index.html)?
In my case, I had heard good things about [From Bash to Z Shell](https://www.amazon.com/dp/1590593766/).

It's a "serious" book (472 pages!) and the beginning is basic ("what is a shell?"),
but it ends up covering both Bash and Zsh, with a bias for Zsh.

Most entertaining book I've ever read? No... but I think it did a fair job at building a solid foundation.

## Oh my Config...

It's hard to talk about Zsh without talking about [Oh My Zsh](https://en.wikipedia.org/wiki/Z_shell#Oh_My_Zsh)...

Personally, I decided not to go that route. I have a strong dislike for the
don't-worry-about-it and everything-you-could-possibly-want approach to
software customization. I've seen it many times in the vim community, there's a
big difference between:

- I'm learning vim...
- I'm learning vim, using someone else's config, and I installed 25 plugins...

I prefer the bottom-up approach to customization, and that's what I decided to do.  
(_maybe_ I'll give oh-my-zsh a try at some point, but I'm happy now)

Config-wise, here's what I did:

- I started with nothing... a pretty barebone but "fair" experience
- I added a few tidbits that I picked up while reading the book
- I ported, over _MANY_ days, most of the functionality I had built up over the years in my Bash [dotfiles](https://github.com/jpalardy/dotfiles)
- over the following weeks, I kept an eye for weird (or different) behavior that I might have to tweak

[Here](https://github.com/jpalardy/dotfiles/blob/main/zsh/zshrc) is the final result, if you're curious. All in all, it amounted to a ton of Googling 😄

## My impressions, so far

Zsh is an excellent shell, and I would gladly recommend it as a first shell to someone starting out.

For someone who's already comfortable with Bash... my recommendations would be
more "mixed". It doesn't seem clear, especially with the time I spent reading
the book and customizing, that "it's worth it".

In fact, maybe it's worth "skipping" Zsh and going directly to
[fish](https://fishshell.com/)? That's probably something I'll try soon (and
report back).

