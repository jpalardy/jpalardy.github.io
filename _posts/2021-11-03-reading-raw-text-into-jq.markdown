---
layout: post
title: Reading Raw Text into jq
category: posts
---
How do you read non-JSON inputs with jq?

This isn't obvious if you don't _already_ know how to do it...

[The manual](https://stedolan.github.io/jq/manual/) says:

{% highlight text %}
--raw-input/-R:

Don't parse the input as JSON. Instead, each line of text is passed to the
filter as a string. If combined with --slurp, then the entire input is passed
to the filter as a single long string.
{% endhighlight %}

Clear yet?

## An Example

{% highlight bash %}
$ cat fruits.txt
apple
banana
cherry
kiwi
orange
peach

$ cat fruits.txt | jq --raw-input .
"apple"
"banana"
"cherry    "
"kiwi"
"orange"
"peach"
{% endhighlight %}

The lines in `fruits.txt` are "naked" strings; not JSON strings (missing double
quotes). What `--raw-input` does is wrap your lines in double quotes: notice
the dangling spaces after `cherry`.

If you try to load `fruits.txt` without `--raw-input`, you get:

{% highlight bash %}
$ cat fruits.txt | jq .
parse error: Invalid numeric literal at line 2, column 0
{% endhighlight %}

Once "bootstrapped" into jq, you can treat it as any JSON input:

{% highlight bash %}
$ cat fruits.txt | jq --raw-input '{(.): (. | length)}' -c
{"apple":5}
{"banana":6}
{"cherry    ":10}
{"kiwi":4}
{"orange":6}
{"peach":5}
{% endhighlight %}

## Slurp

Technically, `fruits.txt` contains 6 lines: it becomes 6 JSON items, treated separately.

If you've done enough jq, your solution is to `--slurp` it, to get an array of strings:

{% highlight bash %}
$ cat fruits.txt | jq --raw-input --slurp .
"apple\nbanana\ncherry    \nkiwi\norange\npeach\n"
{% endhighlight %}

Oh no ... 😬

As per the `--raw-input` documentation (helpfully at the top of this
post), `--slurp` works surprisingly for this case... The whole input, all the
lines, is considered as one giant string.

What's the workaround? As far as I could tell, you are going to need two jq commands to make this work:

{% highlight bash %}
$ cat fruits.txt | jq --raw-input . | jq --slurp .
[
  "apple",
  "banana",
  "cherry    ",
  "kiwi",
  "orange",
  "peach"
]

$ cat fruits.txt | jq --raw-input . | jq --slurp . -c
["apple","banana","cherry    ","kiwi","orange","peach"]
{% endhighlight %}

## Discussion

jq is wonderful once you have JSON ... but a lot of command-line tools don't produce JSON natively.

Using this technique, you can uplift raw text into JSON and modify it into the
shape you need. All the while, you are guaranteed to keep and generate valid
JSON outputs.

The alternatives of text manipulation with sed/awk/perl/etc are (at best!) too error-prone.

