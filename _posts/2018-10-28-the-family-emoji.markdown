---
layout: post
title: "The Family Emoji"
category: posts
---

I was reading [Impatient JS](http://exploringjs.com/impatient-js/index.html) and came up on a [surprising part](http://exploringjs.com/impatient-js/ch_strings.html#caveat-grapheme-clusters):

{% highlight javascript %}
> ...['👨‍👩‍👦']
[ '👨', '‍', '👩', '‍', '👦' ]     // cool: man, woman, and boy emojis...
{% endhighlight %}

but when I tried it:

{% highlight javascript %}
> [...'👪']
[ '👪' ]
{% endhighlight %}

What... why?! Is the book wrong?


# There are 2 "family" emojis...

If you already know the answer, the book is clear... When you search for the
"family emoji" and end up on a [page like this](http://unicode.org/emoji/charts/full-emoji-list.html#family),
you'll see what's going on:

![two family graphemes]({{site.url}}/assets/emoji-family/two-families.png)

There's one codepoint that's already the family emoji. But the same result can be obtained by combining a series of codepoints:

{% highlight javascript %}
> [...'👪'].map(c => c.codePointAt(0))
[ 128106 ]
> [...'👨‍👩‍👦'].map(c => c.codePointAt(0))
[ 128104, 8205, 128105, 8205, 128102 ]

// or, in hex
> [...'👪'].map(c => c.codePointAt(0).toString(16))
[ '1f46a' ]
> [...'👨‍👩‍👦'].map(c => c.codePointAt(0).toString(16))
[ '1f468', '200d', '1f469', '200d', '1f466' ]
{% endhighlight %}

These are the same hexadecimal values as the screenshot above. Everything is right with the world :-)

The U+200d character is the [ZERO WIDTH JOINER](https://en.wikipedia.org/wiki/Zero-width_joiner), abbreviated to ZWJ.
The [joining section](https://en.wikipedia.org/wiki/Emoji#Joining) from the emoji Wikipedia page gives context that
will feel very familiar (pun intended).


# There are all kinds of families

The example above is just one of the many emoji families available:

<div style="font-size: 300%">
👨‍👩‍👦 👨‍👩‍👧 👨‍👩‍👧‍👦 👨‍👩‍👦‍👦 👨‍👩‍👧‍👧
</div>

<div style="font-size: 300%">
👨‍👨‍👦 👨‍👨‍👧 👨‍👨‍👧‍👦 👨‍👨‍👦‍👦 👨‍👨‍👧‍👧
</div>

<div style="font-size: 300%">
👩‍👩‍👦 👩‍👩‍👧 👩‍👩‍👧‍👦 👩‍👩‍👦‍👦 👩‍👩‍👧‍👧
</div>

<div style="font-size: 300%">
👨‍👦 👨‍👦‍👦 👨‍👧 👨‍👧‍👦 👨‍👧‍👧
</div>

<div style="font-size: 300%">
👩‍👦 👩‍👦‍👦 👩‍👧 👩‍👧‍👦 👩‍👧‍👧
</div>


# Additional Resources

I had heard of these things but hadn't fully grasped them until I played with them myself. While
I was trying to figure this out, I found a bunch of good resources:

* Wes Bos has a [tweet with cool examples](https://twitter.com/wesbos/status/769228067780825088?lang=en)
* unicode.org's [full list of emojis](http://unicode.org/emoji/charts/full-emoji-list.html)
* Good intro to [code points vs grapheme clusters](https://manishearth.github.io/blog/2017/01/14/stop-ascribing-meaning-to-unicode-code-points/)
* More [emoji fun](https://manishearth.github.io/blog/2017/01/15/breaking-our-latin-1-assumptions/#emoji)
* Cry a little: [Dark Corners of Unicode](https://eev.ee/blog/2015/09/12/dark-corners-of-unicode/)
* [Awesome Unicode](https://github.com/jagracey/Awesome-Unicode), which I'm just starting to read

