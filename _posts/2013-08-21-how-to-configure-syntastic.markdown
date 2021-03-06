---
layout: post
title: How to Configure Syntastic
category: posts
---

[Syntastic][syntastic] is great. When it's configured properly, it will
highlight warnings and errors inline in the current Vim buffer. Here's the
obligatory Syntastic screenshot:

![Syntastic features](/assets/syntastic/features.png)

My experience with Syntastic was that it worked even though I had done nothing
to configure it. The default configuration had done its job and, when I saved a
buffer, my mistakes would be highlighted.

(I'm going to discuss C, but this applies to any language supported by
Syntastic. I picked C because it was the first language that forced me to
understand how Syntastic worked due to its vast number of checkers.)

Trying to understand how Syntastic works, I dug into the [syntax checkers][syntastic_syntax_checkers]
directory and opened the [c][syntastic_syntax_checkers_c] subdirectory. Inside
I found a bunch of files, each named after the executable used to check the
syntax. That made a lot of sense, I could see where this was going.

![Syntastic C checkers](/assets/syntastic/c_checkers.png)

But which one(s) of these would be used when checking my file? You can find out:

{% highlight text %}
:SyntasticInfo
{% endhighlight %}

and it might look like this on your system:

{% highlight text %}
Syntastic info for filetype: c
Available checkers: gcc make splint
Currently active checker(s): gcc
{% endhighlight %}

Think of it as a funnel:

![Syntastic checkers funnel](/assets/syntastic/funnel.png)

The first one, "ALL the checkers supported by Syntastic" changes over time; as
people contribute more checkers, the list will grow. You can check the
[syntax checkers][syntastic_syntax_checkers] subdirectories on Github or the
[wiki][syntastic_syntax_checkers_wiki].

The second one, "the checkers installed on your computer", is self-explanatory :-)

The last one, "the checker(s) Syntastic will use", is worth discussing. The
logic seems to be the first item from the list from `:SyntasticInfo`'s
"Available checkers" filtered through a [whitelist][syntastic_whitelist].
That's not the whole story, however, because you can skip this logic and
manually tell Syntastic what to use.

Here's what I recommend:

1. start with seeing [what's possible][syntastic_syntax_checkers_wiki]
2. install the checkers you want -- make sure the executable names match what Syntastic expects
3. check `:SyntasticInfo` -- if it matches your needs, you are done.
4. drop a line in your `.vimrc` to specify the checkers

Here's what that config might look like:

{% highlight vim %}
let g:syntastic_c_checkers=['make','splint']
{% endhighlight %}

This follows the `g:syntastic_<filetype>_checkers` format. If you manually
specify that list, you can put multiple checkers. If you do, each checker will
be called, in order, as long as the previous checkers don't return an error.
In that case, you might want to list checkers from fastest to slowest, or from
looser to stricter.

I generalized on a few points, a lot of this behavior is customizable. The whole truth
can be found in the [documentation][syntastic_documentation].

[syntastic]: https://github.com/scrooloose/syntastic
[syntastic_syntax_checkers]: https://github.com/scrooloose/syntastic/tree/master/syntax_checkers
[syntastic_syntax_checkers_c]: https://github.com/scrooloose/syntastic/tree/master/syntax_checkers/c
[syntastic_syntax_checkers_wiki]: https://github.com/scrooloose/syntastic/wiki/Syntax-Checkers
[syntastic_whitelist]: https://github.com/scrooloose/syntastic/blob/d82ee05a80c023f1d531569e56595f5f9cb0fde2/plugin/syntastic/registry.vim#L6
[syntastic_documentation]: https://github.com/scrooloose/syntastic/blob/master/doc/syntastic.txt

