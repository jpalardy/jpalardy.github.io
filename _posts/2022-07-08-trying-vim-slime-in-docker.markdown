---
layout: post
title: Trying vim-slime in Docker
category: posts
---
(Disclaimer: I wrote [vim-slime](https://github.com/jpalardy/vim-slime))

## Installing a vim plugin: probably not fun...

Maybe you've heard about [vim-slime](https://github.com/jpalardy/vim-slime), thought it was cool ... but you weren't sure what you were getting yourself into 🤔

That's understandable ... I feel the same about every vim plugin:

- is it going to be simple to install?
- will it interfere with other plugins?
- if something breaks, will it be easy to fix?
- how much config will be necessary? (for optimum experience)
- is it going to be simple to uninstall?

In this case, I propose a "clean slate" experience. Since you probably don't have a new computer with a fresh OS install lying around, let's talk about Docker.

## Why Docker?

Is Docker perfect? _No_. (especially on macOS)

What I appreciate about Docker is: the mess stays inside a container. You're
always a few commands (`docker rm`, `docker rmi`, `docker system prune`) away from returning to a known/clean state.

I often have to reproduce
[problems](https://github.com/jpalardy/vim-slime/issues) with combinations of
config and tools completely different from how I usually work. I would:

- change my config...
- install new tools...
- hope I could reproduce the problem 🤞
- `git checkout .` my dotfiles back to sanity
- remember to uninstall things...

Nothing about this process would "feel good". Now I try to contain the blast radius inside Docker.

## Instructions: vim-slime in Docker

Set up the foundations:

{% highlight bash %}
docker run -ti --rm alpine
apk update
apk add vim tmux git
{% endhighlight %}

(if, at this point, you're thinking "why alpine?" ... adjust these instructions to your own preferences)

Install vim-slime:

{% highlight bash %}
mkdir -p ~/.vim/pack/plugins/start
cd ~/.vim/pack/plugins/start
git clone https://github.com/jpalardy/vim-slime.git
cd # optional, but gets you back $HOME
{% endhighlight %}

Configure vim-slime:

{% highlight bash %}
echo 'let g:slime_target = "tmux"' > ~/.vim/vimrc
{% endhighlight %}

Try vim-slime:

{% highlight txt %}
1. start tmux:        tmux
2. split your window: ctrl-b "                 <-- ctrl-b, double-quote
3. start vim:         vim
4: in vim, type:      ls -l / | head -n 10
5: in vim, type:      ctrl-c, ctrl-c           <-- from normal mode

at this point, vim-slime will prompt for your tmux config:
1. "tmux socket name or absolute path: default" -- accept
2. "tmux target pane: :" -- replace ":" with "{last}"

"ls -l / | head -n 10" runs in the other pane (where bash was running)
{% endhighlight %}

![showing the results of the instructions above](/assets/trying-vim-slime/minimal-vim-slime.png)

## What's next?

Everything above was "the minimum"; the least number of steps to try vim-slime.  
No magic ❌🪄

Some improvements:

- default tmux is pretty bare, dump your config to `~/.tmux.conf`
- default vim is pretty bare, dump your config to `~/.vim/vimrc`  
(remember to add some vim-slime config...)

A little bit more vim-slime config for your vimrc:

{% highlight vim %}
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_dont_ask_default = 1
{% endhighlight %}

This will use `{last}` and won't even ask for you to confirm the config!  
(this is how I work)

If you don't want to use tmux, there are many other options:

- (GNU) screen
- dtach
- kitty
- x11
- whimrepl
- conemu
- vimterminal
- neovim terminal

See the [README](https://github.com/jpalardy/vim-slime) for details on how to configure things.

Finally, go step by step -- it's easier to debug that way. And if you need help, [open an issue](https://github.com/jpalardy/vim-slime/issues) and we'll figure it out.

