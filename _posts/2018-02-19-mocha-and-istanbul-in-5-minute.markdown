---
layout: post
title: "Mocha and Istanbul in 5 minutes"
category: posts
---

## Who is this for?

This post is for you if:

- you want to get started with tests and test coverage but  
  feel overwhelmed by the details

or

- you already know all this... but will appreciate a "checklist"  
  next time you need to do it all again

I was in the second situation recently and decided to write everything down while it's still fresh.


## Context

You have a Node.js project, but no tests (yet), and you need _just enough_ to get started.

- [Mocha](https://mochajs.org/) is test framework.
- [Istanbul](https://istanbul.js.org/) is a test coverage tool.
- `nyc` is the command-line client for Istanbul.

I put all the files you'll need on [github](https://github.com/jpalardy/mocha-istanbul-in-5m).

This is not a tutorial on how to write tests or how to use Mocha/Istanbul ... but there are some pointers at the end of the post.


## Step by step

### 1. Install your dependencies

{% highlight bash %}
$ npm install --save-dev mocha nyc
{% endhighlight %}


### 2. Create the test directory

{% highlight bash %}
$ mkdir test
$ # paste the following code in test/example.js
{% endhighlight %}

[test/example.js](https://github.com/jpalardy/mocha-istanbul-in-5m/blob/master/test/example.js)

{% highlight javascript %}
const assert  = require('assert');

const pluralize = require('../lib/example').pluralize;

describe('example', function () {
  describe('pluralize', function () {
    it('keeps singular when count is 1', function () {
      assert.strictEqual(pluralize(1, 'cat'), '1 cat');
    });
  });
});
{% endhighlight %}


### 3. Create a file to test

{% highlight bash %}
$ mkdir lib
$ # paste the following code in lib/example.js
{% endhighlight %}

[lib/example.js](https://github.com/jpalardy/mocha-istanbul-in-5m/blob/master/lib/example.js)

{% highlight javascript %}
exports.pluralize = function (count, singular, plural) {
  if (count === 1) {
    return `${count} ${singular}`;
  }
  plural = plural || `${singular}s`;
  return `${count} ${plural}`;
};
{% endhighlight %}


### 4. Edit scripts in package.json

Open your `package.json` and make sure the `scripts` section looks like:

{% highlight json %}
"scripts": {
  "test":     "mocha --reporter dot",
  "coverage": "nyc --reporter html --reporter text npm test"
}
{% endhighlight %}


### 5. Run your tests

{% highlight bash %}
$ npm test
{% endhighlight %}


### 6. Run your test coverage

{% highlight bash %}
$ npm run coverage
$ # open coverage/index.html
{% endhighlight %}


## Overtime

We have tests, we can run them, and we have test coverage: done!

### Comments:

Test coverage is poor, on purpose; to show you how useful Istanbul can be:

![code coverage for example.js](/assets/mocha-and-istanbul-in-5m/coverage-example-js.png)

In this case, you would need more tests:

{% highlight javascript %}
// covers `else`
it('uses explicit plural when given', function () {
  assert.strictEqual(pluralize(3, 'mouse', 'mice'), '3 mice');
});

// covers line 6, after `||`
it('uses implicit plural otherwise', function () {
  assert.strictEqual(pluralize(3, 'cat'), '3 cats');
});
{% endhighlight %}

What's `describe` and `it`? Refer to the excellent [mocha documentation](https://mochajs.org/).

Mocha, by default, runs tests from `test/*.js`, that's why we didn't need to specify test files or directories.

I kept things simple and used Node.js's [assert](https://nodejs.org/api/assert.html) library.

When things get complicated, you'll probably need [sinon](http://sinonjs.org/). Here's a good [tutorial](https://semaphoreci.com/community/tutorials/best-practices-for-spies-stubs-and-mocks-in-sinon-js).


