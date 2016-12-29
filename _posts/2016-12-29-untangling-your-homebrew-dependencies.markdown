---
layout: post
title: "Untangling Your Homebrew Dependencies"
category: posts
---

Does this look familiar?

{% highlight bash %}
$ brew ls | wc -l
217
{% endhighlight %}

Wait, what? When did this happen?!

You can try looking at the  `brew ls` output and try to remember what you
installed when. Your next reflex is probably to search "homebrew dependencies"
because there must be an easy solution...


## The Basics

What are vim's dependencies?

{% highlight bash %}
$ brew deps vim
perl
python
ruby
{% endhighlight %}

Hmmm... what depends on perl?

{% highlight bash %}
$ brew uses perl --installed     # --installed is important, otherwise ALL packages are considered
vim
{% endhighlight %}

How can I see _all_ dependencies?

{% highlight bash %}
$ brew deps --installed
apg:
bash-completion:
cairo: fontconfig freetype glib libpng pixman
coreutils:
dirmngr: libassuan libgcrypt libgpg-error libksba pth
dnsmasq:
docker:
dos2unix:
ffmpeg: lame x264 xvid
findutils:
## truncated ##
{% endhighlight %}


## The Real Question: What Can I Uninstall?

You can uninstall packages no other packages depend on. Thankfully, there's a
command for that:

{% highlight bash %}
$ brew leaves
apg
bash-completion
coreutils
dnsmasq
docker
dos2unix
ffmpeg
findutils
fswatch
gawk
## truncated ##
{% endhighlight %}

but here's some bad news... `brew leaves` is broken!

{% highlight bash %}
$ brew leaves | grep perl
perl
{% endhighlight %}

but, if you remember from above:

{% highlight bash %}
$ brew uses perl --installed
vim
# or
$ brew deps --installed | grep perl
perl:
vim: perl python ruby
{% endhighlight %}

`brew leaves` tells you nobody uses perl, but `brew uses` confirms that vim uses perl...


## Detour: Dependencies and Requirements

Let's look at vim info:

![brew info vim]({{site.url}}/assets/untangling-homebrew-dependencies/brew-info-vim.png)

There are two sections: "dependencies" and "requirements" ... so, what's the difference?

    dependency:  a "real" package you depend on  
    requirement: an "alias" for one of multiple substitute packages

For example: vim needs perl, but it's not picky about _which_ perl is installed.  
If you `brew search perl`, you'll find you have many options; all of which
satisfy vim's "requirement".


## Brew Leaves is Broken

To make a long story short, `brew leaves` only lists dependencies (but not
requirements).

There are a bunch of [homemade solutions](https://www.google.com/search?q=homebrew+dependencies)
out there. I went through homebrew's [code](https://github.com/Homebrew/brew/tree/master/Library/Homebrew/cmd) and `brew deps --installed` is the
complete source of truth.

{% highlight bash %}
$ brew deps --installed
apg:
bash-completion:
cairo: fontconfig freetype glib libpng pixman
coreutils:
dirmngr: libassuan libgcrypt libgpg-error libksba pth
dnsmasq:
docker:
dos2unix:
ffmpeg: lame x264 xvid
findutils:
## truncated ##
{% endhighlight %}

A leaf is a package that never shows up on the right side of the colon.


## brew-graph

If you feel that the output of `brew deps --installed` is not friendly, you're not alone.

[brew-graph](https://github.com/martido/brew-graph) is a ruby script that uses the output of `brew deps --installed` and generates a graph, in GraphViz or GraphML format. After you install brew-graph, you can visualize your dependencies:

{% highlight bash %}
$ brew install graphviz
$ brew graph --installed | dot -Tpng -ograph.png
$ open graph.png
{% endhighlight %}

I think you can get better results by using `fdp`, instead of `dot`, to
generate the image. `fdp` is already installed if `dot` is installed; they are
both part of GraphViz. The [man page](https://linux.die.net/man/1/fdp) says:

> ... fdp draws undirected graphs using a ''spring'' model. It relies on a force-directed approach in the spirit of Fruchterman and Reingold ...

I would run:

{% highlight bash %}
$ brew graph --installed | fdp -Tpng -ograph.png
$ open graph.png
{% endhighlight %}

Which looks like:

![brew deps as graph]({{site.url}}/assets/untangling-homebrew-dependencies/brew-deps.png)


## Modified brew-graph

I [forked](https://github.com/jpalardy/brew-graph) brew-graph to highlight leaf
nodes. Anything in gray is a leaf and can be uninstalled:

![brew deps as graph w/ highlights]({{site.url}}/assets/untangling-homebrew-dependencies/brew-deps-hl.png)

