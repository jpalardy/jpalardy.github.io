---
layout: post
title: "Surviving Unfamiliar JavaScript Projects: package.json"
category: posts
---

This isn't your code or project: you `git clone` and step into the directory...

Where do you start? What's important? How are things organized?


# package.json

A project's `package.json` will tell you [a lot](https://docs.npmjs.com/files/package.json).
All sections are informative, but some are better starting points than others.

Is that too obvious? You can play along with the `package.json` from real projects. The more unfamiliar the project, the better:

* [debug](https://github.com/visionmedia/debug/blob/master/package.json)
* [bunyan](https://github.com/trentm/node-bunyan/blob/master/package.json)
* [lodash](https://github.com/lodash/lodash/blob/master/package.json)
* [ms](https://github.com/zeit/ms/blob/master/package.json)
* [moment](https://github.com/moment/moment/blob/develop/package.json)

Any surprises in there? My answers/spoilers [below](#surprises-from-real-packagejson).


## section: main

{% highlight json %}
"main": "index.js"
{% endhighlight %}

A good place to start ... if you're going to jump in and read some code, this
is the entry point of this project; this is what a `require` would read.


## section: bin

{% highlight json %}
"bin": {
  "nyc": "./bin/nyc.js"
}
{% endhighlight %}

Does this project provide "executables"? If so, that's another kind of entry point
into the code. It comes from a different perspective: doing something useful and specific.

Sometimes it's obvious what's in there, sometimes not. It's usually worth a look.


## section: scripts

_this snippet was trimmed down to simplify_

{% highlight json %}
"scripts": {
  "test": "npm run clean && npm run build && ...",
  "clean": "rimraf ./.nyc_output ./node_modules/.cache ...",
  "build": "node ./build-tests"
  ...
}
{% endhighlight %}

Other languages have Makefiles, Rakefiles, or something else. The `scripts` section ends up
being a dumping ground for useful "commands" and "recipes".

Look for the unexpected.


## section: \*dependencies

People don't write code anymore, people [glue code](https://www.wisdomandwonder.com/link/2110/why-mit-switched-from-scheme-to-python) together until it's useful.

Yes, `dependencies` and `devDependencies`
([and](https://docs.npmjs.com/files/package.json#optionaldependencies) [others](https://docs.npmjs.com/files/package.json#peerdependencies))
contain "everything", but it doesn't tell you where and why.

Also, it's probably not up to date:

- old versions
- versions with security flaws
- unused dependencies: not used but found in `package.json`
- missing dependencies: used but not found in `package.json`

The good news is that you don't have to do this alone, [there are tools to help](/posts/surviving-unfamiliar-javascript-projects-dependencies/).


# Surprises from real package.json

When I read a `package.json`, I look for the unexpected. Here are some things that caught my eye:

[debug](https://github.com/visionmedia/debug/blob/master/package.json)

* What's the [browser](https://docs.npmjs.com/files/package.json#browser) section?

[bunyan](https://github.com/trentm/node-bunyan/blob/master/package.json)

* bunyan has an executable?! [What](https://github.com/trentm/node-bunyan#cli-usage) does it do?

[lodash](https://github.com/lodash/lodash/blob/master/package.json)

* `lodash.js` is the `main` entry point...
* but lodash allows you to require only what you need, maybe just one function: `require("lodash/compact")`
* check the [base](https://github.com/lodash/lodash) of the project to see ALL the code...

[ms](https://github.com/zeit/ms/blob/master/package.json)

* No `dependencies`! It's a cute little library.

[moment](https://github.com/moment/moment/blob/develop/package.json)

* Also no `dependencies`... but a ton of code.
* There's a bunch of non-standard sections in the package.json

