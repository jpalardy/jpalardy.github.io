---
layout: post
title: "Handling Broken JSON with jq"
category: posts
---

## Problem

{% highlight bash %}
$ cat broken.json
{
"color": "red"
}
{
"color": "green"
{
"color": "blue"
}
{% endhighlight %}

_There's a missing `}` after green._

{% highlight bash %}
$ cat broken.json | jq .
{
"color": "red"
}
parse error: Expected separator between values at line 6, column 1
{% endhighlight %}


When jq hits invalid JSON, it completely _stops_ processing the stream.  
That's not always great.


## Some Unhelpful Solutions

People will be quick to "fix" your problem:

> why don't you fix the JSON at the source?

If you can do this, that's the cleanest way out of this.

But... real life is messy. You don't always control the JSON you have to process.  
I ran into this recently: I extracted JSON logs from a system that decided to
truncate _some_ lines, _some_ of the time.

> why don't you "check" your JSON before you ... "check" your JSON?

Yes -- you _could_ do some minimal regex-based checks, possibly with AWK or grep.  
But you know what's already great at handling JSON? jq.


## Using `--seq`

That's what you'll find if you [keep searching](https://www.google.com/search?q=jq+broken+json).
The [documentation](https://stedolan.github.io/jq/manual/) says:

{% highlight text %}
    --seq:

    Use the application/json-seq MIME type scheme for separating JSON texts in jq’s
    input and output. This means that an ASCII RS (record separator) character is
    printed before each value on output and an ASCII LF (line feed) is printed
    after every output. Input JSON texts that fail to parse are ignored (but warned
    about), discarding all subsequent input until the next RS. This mode also
    parses the output of jq without the --seq option.
{% endhighlight %}

but an example might be clearer:

{% highlight bash %}
$ cat broken-with-rs.json
<RS>
{
"color": "red"
}
<RS>
{
"color": "green"
<RS>
{
"color": "blue"
}
{% endhighlight %}

Just put `RS` (ASCII character 0x1e) in front of each record. See below for [an example](#an-example).  
(_or check the [internet draft](https://tools.ietf.org/html/draft-ietf-json-text-sequence-09) for more details_)

{% highlight bash %}
$ cat broken-with-rs.json | jq --seq .
{
"color": "red"
}
{
"color": "blue"
}
{% endhighlight %}

_The broken "green" entry is skipped..._


## Why isn't there a better solution?

When a JSON parser finds a problem, what's the _best_ solution?

I don't think there is one.

If the JSON is invalid ... how much of it needs to be thrown out?

* only the current field? -- `"color": "green"`
* only the current record? inside the closest curlies? -- `{ ... }`

The answer is probably application-specific. And wouldn't it be _worse_ if jq
silently skipped invalid JSON? How long would it take to debug that?!

With `RS` delimiters, you're explicitly boxing failures: on a parse error, it
skips the current record and forwards to the next `RS`.


## An Example

{% highlight bash %}
$ cat broken.json | sed -e 's/^{/'$(printf "\x1e")'{/' | jq --seq .
{
"color": "red"
}
{
"color": "blue"
}
{% endhighlight %}

_Catch lines beginning with `{` and insert a `RS` there._

**DISCLAIMER** again: the broken "green" entry is skipped... in this case it's silent,
but I've seen other broken cases where a message is shown on STDERR. Use responsibly.


