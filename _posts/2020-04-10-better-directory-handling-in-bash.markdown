---
layout: post
title: "Better Directory Handling in Bash"
category: posts
---

When dealing with directories in bash, some obvious things seem like too much work...

Here are 2 quick tips for easier handling of directories in bash.

## unix-filename-rubout

When dealing with long directory names, you can usually complete forward by pressing `TAB`.
But going backward? ... that usually means pressing `BACKSPACE` repeatedly.

There is a better way: `unix-filename-rubout`. Add this to your `~/.inputrc`:

{% highlight bash %}
"\C-f": unix-filename-rubout
{% endhighlight %}

What does it do?

![moving back and forth between directories]({{site.url}}/assets/directory-handling-in-bash/front-and-back.gif)

(_TAB forward, ctrl-f backward_)

Every time you hit `ctrl-f`, it deletes backward until the previous `/`: useful!

Why `ctrl-f`?

By default, in bash, it's not mapped to anything. And it's easy to type. You
can check your bindings with `bind -P`:

{% highlight bash %}
> bind -P | grep rubout
unix-filename-rubout is not bound to any keys
# rest snipped out
{% endhighlight %}

(detour: use `bind -P` to see what is bound to each `ctrl` keys)

## cd to filename

What _usually_ happens if you try to cd to a filename?

{% highlight bash %}
> cd /etc/hosts
-bash: cd: /etc/hosts: Not a directory
# what do you think I meant?! ... 🤬
{% endhighlight %}

(this happens often when copying-pasting path)

For years, I swore at bash, manually deleted the last part of the path, and
tried again. In fact, that's what drove me to find `unix-filename-rubout` in the
first place.

There's no built-in fix for this, but it's not too complicated to wrap the `cd` in a function
and add some extra quality-of-life logic in there:

{% highlight bash %}
# to add to your bash dotfiles

# wraps `cd`, other behaviors can be added
cd() {
  local dest="${@:-"$HOME"}"
  if [ -f "$dest" ]; then
    dest=$(dirname "$dest")
  fi
  builtin cd "$dest"
  return $?
}
{% endhighlight %}

in short: if the path is a filename, use the directory containing the file instead!

{% highlight bash %}
> cd /etc/hosts
> pwd
/etc
{% endhighlight %}

## Conclusion

When using a shell, it's often the "little things" that turn chores into seamless experiences.

Give those a try and let me know about your own tweaks.

