---
layout: post
title: Fish Shell is Awesome
category: posts
---

(when I [switched my shell to zsh](https://blog.jpalardy.com/posts/first-look-at-zsh/), I
mentioned that I would try [fish](https://fishshell.com/) and report back: this is it.)

TLDR:
- fish shell is awesome!
- including features I didn't know I wanted
- but, it's not common -- enjoy it on your own devices, but don't expect it to be the default shell when you ssh somewhere

## Truth in Advertising

The front page of the [fish shell](https://fishshell.com/) has a "sales pitch"

[![the fish shell advantages, as shown on the home page](/assets/fish-shell/sales-pitch.png)](https://fishshell.com/)

I rediscovered it while coming up with my own list of what makes fish great. But the pitch
already has most of my points -- fish shell had tried to tell me all along, I just hadn't believed it!

## Try Before You Buy

I think the biggest fears when switching shells come down to:
- how to try it without messing up your current setup?
- how much configuration/googling will you need before being productive?

For the first point, once installed (`brew install fish`, or equivalent), just
type `fish`. You will be running fish without fiddling with your terminal or
default shell. If you don't like it, type `exit` to return to your "real"
shell. This is low commitment!

For the second point, I have some good news:
- the fish config is sane by default!  
  (a refreshing development over bash/zsh)
- there are surprisingly little knobs and settings to play with: trust the defaults!

If you want to customize the colors or the prompt, type `fish_config` and enjoy the
browser-based config and preview.

![preview of the fish_config web based user interface](/assets/fish-shell/web_config.png)

## All About Completion

The feature that makes or breaks a shell is what happens when you press `TAB`.
I would _NOT_ be talking about fish if its completion wasn't excellent.

Let me try to summarize with a few examples:

![fish knows in advance when commands won't work](/assets/fish-shell/command-not-found.png)

- the red highlight had already told me that the command wouldn't work...
- fish checks while you type

![fish remembers what you typed and hints from history](/assets/fish-shell/history-hints.png)

- valid commands are cyan (customizable)
- completed words are underlined (I pressed `TAB` to complete the filename)
- the grey text comes from the command history
- right-arrow will complete the grey text (not `TAB`)
- `ctrl-f` would grab the first word from the grey text (if there were multiple words)

Yes, other shells have history completion -- the difference is that it shows up
automatically. With bash/zsh, you have to remember that a command is in
your history to want to grab it with `ctrl-r`.

More about command history:

- fish history in _almost_ infinite (it stores [256k entries, in a LRU](https://github.com/fish-shell/fish-shell/issues/2674))
- history hints are directory-aware ... offering you commands you would only type in certain directories!
- multi-shell histories are merged on shell exit: no clobbers, no worries

Other features worth mentioning:
- out-of-the-box installation comes with completions for most commands
- man page can be parsed to generate completions (as claimed in sales pitch)
- rsync/scp commands complete paths on the other side of an ssh connection (!)
- flag completion, with helpful text (below)

![press TAB to show command-line flag completion and help](/assets/fish-shell/flag-completion.png)

A few other things:
- case-insensitive (case-flexible?) completion -- type it lowercase and `TAB` fix it!
- middle-of-text completion -- you don't have to type the beginning of a filename/directory, any unambiguous part will do

## What's the Catch?

The biggest catch is that it's not default. You have to install it
(probably) and enable it. Default choices are powerful, and that's why bash/zsh
still rule.

You can reduce the pain by "cheating". Add `fish` to the bottom of your `.bashrc`/`.zshrc`

{% highlight bash %}
# pretty easy, no?
fish
{% endhighlight %}

Comment it out if you change your mind.

A few other things to know:
- fish syntax, if you are scripting, isn't the same bash/zsh syntax -- you might say it's a good thing. I read through the [language reference](https://fishshell.com/docs/current/language.html) and found it reasonable. (better than sh's `CASE`-`ESAC`, `IF`-`FI`, `DO`-`DONE` craziness...)
- it's worth reading through [Fish for bash users](https://fishshell.com/docs/current/fish_for_bash_users.html); it's not too long

So, yes, fish will spoil you. And if you have to use other shells, you will miss its features.

Is that such a bad thing?

## Final Worlds

> Technology becomes truly useful when it becomes invisible.

I spent years trying to beat bash (and zsh) into shape. Many of my blog posts
were about removing friction from the command-line experience. There is _some_
joy in mastering complicated tools...

But fish allowed me to do everything I wanted, and more, without feeling like a struggle. (or worse: spending days/weeks/months getting my configuration just right)

Give fish a try and let me know what's missing.


