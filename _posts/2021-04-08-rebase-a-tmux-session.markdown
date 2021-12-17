---
layout: post
title: Rebase a Tmux Session
category: posts
---

[Spanish Translation](http://expereb.com/reajustar-de-una-sesion-de-tmux/), thanks to Laura.  
[Georgian Translation](http://lpacode.com/rebase-a-tmux-session/), thanks to Ana.  
[Bulgarian Translation](https://guideslib.com/publications/rebase-a-tmux-session/), thanks to Zlatan.

Whatever directory you start a new Tmux session in, that's the directory that
will be used for each new window you create.

Tmux is the workhorse of my local development workflow. When I `cd`
into a directory and start working outside a Tmux session, it _feels_ like
something is missing.

There's always a need to get a new shell to check something or run a quick
test. I open a bunch of windows: some permanent (which I usually name), most disposable.

![example tmux session with named windows](/assets/rebase-tmux/session-with-named-windows.png)

## The Problem

Once the session is started, the "start directory" is set and fixed.

If, in the middle of a session, I needed to focus on a subdirectory, or move
elsewhere, I had several sub-optimal choices:

- explicitly `cd` to the new directory, after opening each new window
- exit the session, and start a new one in the new directory
- start a new session, in another terminal, in the new directory

This had happened enough times to justify looking for a better way...

## The Solution

Add this to your `$HOME/.tmux.conf` ([here's mine](https://github.com/jpalardy/dotfiles/blob/54c2d416f2a291c6c7f932d9d930b560f819c828/tmux.conf#L22)):

{% highlight text %}
bind _ attach-session -t . -c '#{pane_current_path}'
{% endhighlight %}

(you might need to restart Tmux, or reload its config)

My prefix is `ctrl-a`, and this binds a command to the underscore: `_`. The
`pane_current_path` is the `$PWD` of the window you are using when invoking the
binding. [You can do this from Tmux's command mode too](https://codelearn.me/2018/12/14/tmux-change-default-start-dir.html).

The underscore made sense to me, but feel free to customize the binding.

## Experience

Being able to "re-use" my sessions has been very convenient. I don't spend too
much time thinking about "the best" directory to start a session from; I can
always fix it later.

