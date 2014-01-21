---
layout: post
title: "The bash-completion Problem"
category: posts
---

The [bash-completion](http://bash-completion.alioth.debian.org/) package adds
a bunch of useful features, but it also *limits* what happens when you press `tab`.
For example, the "text editor" completion excludes files that probably are not text files:

{% highlight text %}
complete -f -X '*.@(o|so|so.!(conf)|a|[rs]pm|gif|jp?(e)g|mp3|mp?(e)g|avi|asf|ogg|class)' vi vim gvim rvim view rview rgvim rgview gview emacs xemacs sxemacs kate kwrite
{% endhighlight %}

And the sqlite3 completion tries to outsmart you:

{% highlight bash %}
local dbexts='@(sqlite?(3)|?(s?(3))db)'
{% endhighlight %}

It looks **only** for files with an extension .sqlite, .sqlite3, .s3db, .sdb, .db.

When `tab` doesn't do what you expect, you can try to read the source. If
you aren't sure what completions you have, try this:

{% highlight text %}
% complete | head
complete -F _kill kill
complete -F _renice renice
complete -F _postconf postconf
complete -F _ldapwhoami ldapwhoami
complete -F _ldapaddmodify ldapadd
complete -F _java java
complete -F _filedir_xspec oodraw
complete -F _filedir_xspec elinks
complete -F _filedir_xspec freeamp
complete -o default -F _longopt split
{% endhighlight %}


## The temporary fix: meta-/

But wait ... isn't bash-completion just trying to _help_?! Isn't it doing the
right thing most of the time?

Tab completion is awesome when it works, but it can drive you crazy when it doesn't.

If you press `tab` and nothing happens ... try pressing: `meta-/`
(try: `ESC-/` or `alt-/`) to force file completion.


## The permanent fix: complete -r

You can remove a specific completion manually:

{% highlight text %}
% complete -r sqlite3
{% endhighlight %}

or you can integrate it after you [source bash-completion](https://github.com/jpalardy/dotfiles/blob/master/bash/completion/bash.bash): (line 4 and 5)

{% highlight bash linenos %}
for dir in /usr/local/etc /etc; do
  if [ -e ${dir}/bash_completion ]; then
    source ${dir}/bash_completion
    complete -r vim
    complete -r sqlite3
    break
  fi
done

if [ -z "$BASH_COMPLETION" ]; then
  echo "no bash-completion"
fi
{% endhighlight %}

* it looks for bash-completion in the usual places
* it source the first one it finds
* it removes completions I didn't want
* it warns you if it couldn't find it -- for example, on a new machine, before you install everything you need

In the end, whether you fix the problem short-term or long-term depends on how
annoying this is to you.

