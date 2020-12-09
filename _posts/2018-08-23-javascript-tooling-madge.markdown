---
layout: post
title: "JavaScript tooling: madge"
category: posts
---

In large projects, the way files depend on each other is not always clear.

# Dependencies

What files does _this_ file depend on?

> Easy: look for the `require` or `import` statements.

What files depend on _this_ file?

> Uh... use `grep`?

You can get answers, but it's the _micro_ view. What about the big picture?  
Let's look at ALL files and ALL dependencies at the same time.


# Madge

[Madge](https://github.com/pahen/madge)

> Create graphs from your CommonJS, AMD or ES6 module dependencies

Short version:

- step into a project
- run `madge`, feed it the source files
- look at the generated image

Here's what happens when you run Madge on itself:

![madge on madge](/assets/surviving-unfamiliar/madge-on-madge.svg)

(you might need to install [graphviz](https://www.graphviz.org/), follow the [instructions](https://github.com/pahen/madge#graphviz-optional))

{% highlight bash %}
# HOW TO ^^^
git clone https://github.com/pahen/madge.git
cd madge/
npm install
node bin/cli.js bin -i madge-on-madge.svg
{% endhighlight %}

But what about a bigger project? Here's [immutable.js](https://github.com/facebook/immutable-js/) (click to enlarge):

[![immutable](/assets/surviving-unfamiliar/immutable.png)](/assets/surviving-unfamiliar/immutable.png)

{% highlight bash %}
# HOW TO ^^^
git clone https://github.com/facebook/immutable-js.git
cd immutable-js/
madge src -i immutable.png   # assumes: `npm install -g madge`
{% endhighlight %}

If you want to focus on a part of the graph, you can start at a specific file (Seq.js):

[![part of immutable](/assets/surviving-unfamiliar/seq.png)](/assets/surviving-unfamiliar/seq.png)

{% highlight bash %}
# HOW TO ^^^
madge src/Seq.js -i seq.png
{% endhighlight %}

What do the colors mean?

- blue files have dependencies
- green files DO NOT have dependencies
- red files have circular dependencies (!)

# How to use?

The [README](https://github.com/pahen/madge#cli) has a bunch of examples.

You can:
- run madge only on specific files, directories, or combinations of both
- show dependencies
- show circular dependencies
- show "orphans" -- files not required by any other files (!)

It also supports many formats:
- text
- JSON
- dot (graphviz)
- image (png, svg, ...)

You can even exclude files:

{% highlight bash %}
madge --exclude '^(foo|bar)\.js$' path/src/app.js
{% endhighlight %}

which is useful for non-interesting files (i.e. configuration files, or tests).

