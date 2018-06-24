---
layout: post
title: "Surviving Unfamiliar JavaScript Projects: dependencies"
category: posts
---

The chances to find a JavaScript project will all dependencies correct and
up-to-date is almost zero. For some dependencies, just stepping out for coffee
_almost_ puts you at risk of falling behind.

It's not a question of "falling behind", that's a given. It's a question
of figuring out what packages are outdated and by how much.


# npm outdated

A good first step is built in npm: when you run `npm outdated`, you get an output similar to this:

![npm outdated output]({{site.url}}/assets/surviving-unfamiliar/npm-outdated.png)

"Package" is obvious, but let's clarify the others:

- Current: what's currently installed locally in `node_modules`
- Wanted: the maximum version compatible with the semver in your `package.json`
- Latest: the most up-to-date, the latest, version in npm

You need to be responsible with when and how you upgrade. I personally enjoy
the lets-see-what-breaks approach to upgrading... it's often faster and more
definitive than researching CHANGELOGs and READMEs for clues.

If you want to jump to the latest version of everything, let's talk about `ncu`.


# ncu

`ncu`, from the [npm-check-updates](https://github.com/tjunnone/npm-check-updates) package, also tries to evaluate your
`package.json` against the package versions out there:

![ncu output]({{site.url}}/assets/surviving-unfamiliar/ncu.png)

The output might be a _little_ easier to parse compared to `npm outdated`. But
the real value happens if you run `ncu -u`: it will update your `package.json`
with the versions from the 2nd column.

Even if you don't want all the changes from `ncu -u`, I find it's easier to run
it and revert lines from the `package.json` manually. It certainly feels faster
than copy-pasting version numbers in `package.json`.


# nsp and npm audit

If you're not ready to upgrade, you might still want to check if you're relying on packages
with known security problems. [nsp](https://github.com/nodesecurity/nsp) (Node Security Platform) provides
a tool to audit the packages you depend on:

[![nsp output]({{site.url}}/assets/surviving-unfamiliar/nsp.png)]({{site.url}}/assets/surviving-unfamiliar/nsp.png)
(output truncated ^)

As mentioned in the [nsp README](https://github.com/nodesecurity/nsp):

> The Node Security Platform has been acquired by npm

As of npm version 6, you can get a similar output to `nsp` with `npm audit`:

[![npm audit output]({{site.url}}/assets/surviving-unfamiliar/npm-audit.png)]({{site.url}}/assets/surviving-unfamiliar/npm-audit.png)
(output truncated ^)


# depcheck

[depcheck](https://github.com/depcheck/depcheck) does not _trust_ what your
`package.json` says, it goes out into the project's code and _verifies_. For
each dependency, it checks that it is `require`d. Conversely, it checks that
each `require` is present in the `package.json`.

![depcheck]({{site.url}}/assets/surviving-unfamiliar/depcheck.png)

It's not perfect but it's better than the alternative (hoping everything is
ok?). There are ways to configure it to ignore false positives too. Check the
[README](https://github.com/depcheck/depcheck) for more details.


# Searching for packages

Whenever I encounter a package I'm not familiar with, I check the Github's
README to give me an idea what it's used for.

For example, what is [cross-env](https://github.com/kentcdodds/cross-env)?

There are more direct ways to find a project's repo than Googling it.
Open a terminal anywhere (whether in a project or not) and type:

{% highlight bash %}
$ npm home cross-env
{% endhighlight %}

That will open your browser to the `homepage` entry of a package's `package.json`.

You can also search package's name on [npmjs.com](https://www.npmjs.com/)
(here: [cross-env](https://www.npmjs.com/search?q=cross-env))

But I found that using [yarnpkg.com](https://yarnpkg.com/en/) (here:
[cross-env](https://yarnpkg.com/en/packages?q=cross-env)) is the best
experience. You don't have to use yarn to enjoy their search engine.

The number of downloads in the last 30 days gives you an idea about
how popular different projects are:

![cross-env]({{site.url}}/assets/surviving-unfamiliar/cross-env.png)

