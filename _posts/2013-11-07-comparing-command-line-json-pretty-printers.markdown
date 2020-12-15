---
layout: post
title: Comparing Command-Line JSON Pretty Printers
category: posts
---

Trying to read badly-formatted JSON is just a waste of time. On the
command-line, or in your text editor with
[filtering](http://usevim.com/2012/06/29/vim101-pipe/), there are tools that
will fix your JSON and make everything right.

There are many options and none are perfect, let's review our choices:

[![JSON tool comparison](/assets/jsonpp/grid.png)](/assets/jsonpp/grid.png)

(click to enlarge)

## Input Files

The worst-case is what I used: a mix of strings, numbers, and booleans without
any human-friendly spaces or alignment.

sample.json:
{% highlight javascript %}
{"first":"Jimmy","last":"James","age":29,"sex":"M","salary":63000,"registered":false}
{% endhighlight %}

The ideal output is the following:
{% highlight javascript %}
{
  "first": "Jimmy",
  "last": "James",
  "age": 29,
  "sex": "M",
  "salary": 63000,
  "registered": false
}
{% endhighlight %}

I also thought it would be interesting to see how pretty-printers would react to invalid JSON.
I took sample.json and changed a few things.

invalid.json:
{% highlight text %}
{"first":Jimmy","last":"James","age":29,"sex":"M","salary":63000"registered":false}
{% endhighlight %}

Can you spot (all) the mistakes? That's my point -- you **don't** have to -- that's
what computers are for.

## Discussion: python -m json.tool

Use the json.tool module from python which will pretty-print STDIN by default.

{% highlight text %}
# cat sample.json | python -m json.tool
{
    "age": 29,
    "first": "Jimmy",
    "last": "James",
    "registered": false,
    "salary": 63000,
    "sex": "M"
}
{% endhighlight %}

{% highlight text %}
# cat invalid.json | python -m json.tool
No JSON object could be decoded
{% endhighlight %}

### pros

* python is probably already installed on your computer

### cons

* order of the keys is changed -- alphabetized, it seems
* no help if the JSON is invalid -- you're on your own


## Discussion: YAJL

[YAJL](https://lloyd.github.io/yajl/) is written in C and can be installed
with your favorite package manager. The command you want to use is
`json_reformat`.

{% highlight text %}
# cat sample.json | json_reformat
{
    "first": "Jimmy",
    "last": "James",
    "age": 29,
    "sex": "M",
    "salary": 63000,
    "registered": false
}
{% endhighlight %}

{% highlight text %}
# cat invalid.json | json_reformat
lexical error: invalid char in json text.
                                        {"first":Jimmy","last":"James"
                     (right here) ------^
{% endhighlight %}

### pros

* order of the keys is preserved -- no funny business
* tries to help with invalid JSON

### cons

* needs to be installed
* didn't find the real problem in the invalid JSON


## Discussion: jq

[jq](https://stedolan.github.io/jq/) is written in C and can be installed
with your favorite package manager.

{% highlight javascript %}
# cat sample.json | jq .
{
  "registered": false,
  "salary": 63000,
  "sex": "M",
  "age": 29,
  "last": "James",
  "first": "Jimmy"
}
{% endhighlight %}

{% highlight text %}
# cat invalid.json | jq .
parse error: Invalid numeric literal at line 1, column 15
{% endhighlight %}

### pros

* colored output -- only on terminal, can be disabled
* tries to help with invalid JSON
* pretty-printing is only one of the things jq does -- it's a powertool that replaces sed/awk/grep

### cons

* order of the keys is changed -- hash order?
* didn't find the real problem in the invalid JSON
* needs to be installed


## Discussion: jsonlint

[jsonlint](https://github.com/zaach/jsonlint) is an NPM package: `npm install -g jsonlint`.

{% highlight text %}
# cat sample.json | jsonlint
{
  "first": "Jimmy",
  "last": "James",
  "age": 29,
  "sex": "M",
  "salary": 63000,
  "registered": false
}
{% endhighlight %}

{% highlight text %}
# cat invalid.json | jsonlint
[Error: Parse error on line 1:
{"first":Jimmy","last":"James
---------^
Expecting 'STRING', 'NUMBER', 'NULL', 'TRUE', 'FALSE', '{', '[', got 'undefined']
{% endhighlight %}

### pros

* optimal output
* order of the keys is preserved -- no funny business
* will tell you exactly what's wrong with your invalid JSON

### cons

* needs to be installed


## Discussion: jsontool

[jsontool](https://github.com/trentm/json) is an NPM package: `npm install -g jsontool`. The command you
want to use is `json`.

{% highlight text %}
# cat sample.json | json
{
  "first": "Jimmy",
  "last": "James",
  "age": 29,
  "sex": "M",
  "salary": 63000,
  "registered": false
}
{% endhighlight %}

{% highlight text %}
# cat invalid.json | json
json: error: input is not JSON: Unexpected 'J' at line 1, column 10:
        {"first":Jimmy","last":"James","age":29,"sex":"M","salary":63000"registered":false}
        .........^
{"first":Jimmy","last":"James","age":29,"sex":"M","salary":63000"registered":false}
{% endhighlight %}

### pros

* optimal output
* order of the keys is preserved -- no funny business
* will tell you exactly what's wrong with your invalid JSON
* it can group / extract / filter

### cons

* needs to be installed


## Conclusion

I used to install YAJL but now, since I always install node.js and NPM, I skip it.

Here's what I used to recommend:

* use python if you have nothing else, or if it does what you need
* otherwise use jq, for pretty printing and for [everything](https://stedolan.github.io/jq/manual/) else it does -- jq is amazing
* but use jsontool if you care about key ordering -- for example, if you're reformatting package.json

However, now that I have compiled this grid, I would use jsonlint instead of jsontool. I always
install jsonlint anyway, because that's what [syntastic](https://blog.jpalardy.com/posts/how-to-configure-syntastic/)
integrates with -- I just had not realized that the output of both jsonlint and jsontool is equivalent.

