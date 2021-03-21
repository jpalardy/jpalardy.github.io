---
layout: post
title: cd.. Until .git Directory
category: posts
---
For years, I've been solving the wrong problem:

> how do I `cd..` efficiently?

I realized that my __real__ problem was:

> how do I `cd..` back to a project's root directory?

The insight, obvious in retrospect, is that most projects have a `.git` directory
at their base.

## The Manual Way...

I've played with multiple solutions over the years, the fully [manual one](https://github.com/jpalardy/dotfiles/blob/03099574c68edfb56e21ff8fec4bf3da09339ac7/zsh/commands/cd.zsh#L16-L18):

{% highlight bash %}
# almost this, see link above
alias b="cd .."

# it's easy to type :-)
{% endhighlight %}

I also tried a [pick from a list](https://github.com/jpalardy/dotfiles/blob/03099574c68edfb56e21ff8fec4bf3da09339ac7/zsh/commands/cd.zsh#L21-29) one:

{% highlight bash %}
# pick parent dir with fzf
bu() {
  run-not-blank cd $(
    local p=$PWD
    while [ $p != "/" ]; do
      echo $p
      p=${p:h}
    done | fzf
  )
}
{% endhighlight %}

which looks like this (not bad):

![bu example](/assets/cd-until-git/bu.png)

I've been relatively happy with a combination of these. The problem with both is how "fragile"
they feel. If I `cd` to the wrong place, getting back to the right directory is
enough effort to break me out of the flow.

## The Automated Way

Let the script look "backward" up the parent directories, looking for the first `.git` directory it can find:

{% highlight bash %}
# cd .. until a .git directory is found
cd_() {
  local p=$PWD
  while [ $p != "/" ]; do
    if [ -d "$p/.git" ]; then
      cd "$p"
      break
    fi
    p=${p:h}
  done
}

# won't cd unless a .git directory is found
# can be used multiple times if multiple .git parents are expected
{% endhighlight %}

I had already "extended" the `cd` command with a wrapper function. For the sake of my muscle memory, I decided to delegate `cd _` to `cd_`:

{% highlight bash %}
# wrap `cd`, add behaviors
cd() {
  local dest="${@:-"$HOME"}"
  if [ "$dest" = "_" ]; then
    cd_ "$dest"
    return
  fi
  if [ -f "$dest" ]; then
    dest=${dest:h}
  fi
  builtin cd "$dest"
}
{% endhighlight %}

both functions are available in [cd.zsh](https://github.com/jpalardy/dotfiles/blob/03099574c68edfb56e21ff8fec4bf3da09339ac7/zsh/commands/cd.zsh) from my [dotfiles](https://github.com/jpalardy/dotfiles).

(why `_` / underscore? ... it seemed unlikely to conflict with a real directory name, is relatively easy to type, and is the thing that came to mind when I thought "base")

