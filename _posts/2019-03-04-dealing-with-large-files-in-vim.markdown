---
layout: post
title: "Dealing with Large Files in Vim"
category: posts
---

Vim is fast, that's one of its main selling points. In general, it can deal with very large files easily.

But there are ways to ruin your Vim experience, and it's not especially hard:
- opening LARGE files, with syntax highlighting
- opening generated files (uglified JavaScript, for example), and letting [ALE](https://github.com/w0rp/ale) run a linter on the contents

That second case is the one that has burned me recently: it pegged my CPU to 100% for a few minutes and completely _blocked_ Vim while
it tried to flag everything. The file itself wasn't particularly large, it was less than 250KB.

The solution for these cases is to turn off **_everything_**: highlighting and plugins:

{% highlight bash %}
$ vim -u NONE filename
{% endhighlight %}

`man vim` says:

    -u {vimrc} Use the commands in the file {vimrc} for initializations.
    All the other initializations are skipped. Use this to
    edit a special kind of files. It can also be used to skip
    all initializations by giving the name "NONE". See ":help
    initialization" within vim for more details.

If Vim is stuck, I haven't found a way to fix that directly; `ctrl-c` or
`ctrl-\` won't help in this case. I've had to `kill` Vim, although `15`/`TERM` is enough, to
make it stop.

