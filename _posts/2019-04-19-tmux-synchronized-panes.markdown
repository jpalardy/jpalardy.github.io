---
layout: post
title: "tmux Synchronized Panes"
category: posts
---

tmux can send the text you type to multiple panes:

[![demo of tmux synchronized panes](/assets/tmux-sync-panes/synchronize-panes.gif)](https://sanctum.geek.nz/arabesque/sync-tmux-panes/)  
(_[screenshot source](https://sanctum.geek.nz/arabesque/sync-tmux-panes/)_)

Even though I've used tmux for years, I never realized that it could do that
until my colleague (thanks [@laurence_man](https://twitter.com/laurence_man)!)
told me about it.

It's similar to [clusterssh](https://github.com/duncs/clusterssh) _without_ having to ssh anywhere. 😄

Call it from the tmux command line:

{% highlight text %}
# toggle
:setw synchronize-panes

# or, explicit on/off
:setw synchronize-panes on
:setw synchronize-panes off
{% endhighlight %}


## Make it easy: key binding

Having to type `:setw synchronize-panes` is too much work. I added this to tmux.conf:

{% highlight text %}
# toggle synchronize-panes
bind C-x setw synchronize-panes

# that's prefix + ctrl-x ^^
{% endhighlight %}

I don't necessarily recommend that key binding, pick something that works for
you. [Other people](https://stackoverflow.com/questions/16325449/how-to-send-a-command-to-all-panes-in-tmux)
use `ctrl-x` (without prefix) but that conflicts with some bash/vim bindings.


## Make it obvious: window status

If the panes are synchronized, I want an easy way to tell. I added this to tmux.conf:

{% highlight text %}
setw -g window-status-current-format '#{?pane_synchronized,#[bg=red],}#I:#W'
setw -g window-status-format         '#{?pane_synchronized,#[bg=red],}#I:#W'
{% endhighlight %}

The `pane_synchronized` variable can be used for conditional coloring in the window status. ([inspiration](https://superuser.com/questions/710498/tmux-visual-indication-if-panes-are-synchronized))

![synchronized pane highlighted in red](/assets/tmux-sync-panes/window-status-red.png)

Guess which window has synchronized panes ^

Feel free to check [my tmux.conf](https://github.com/jpalardy/dotfiles/blob/main/tmux.conf) and grab the parts you like.

