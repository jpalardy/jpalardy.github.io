---
layout: post
title: "Git: How to Find Modified Files on a Branch"
category: posts
---

(_Update 2020-03-01: there's a better way to do this, see [below](#addendum)_)

## Situation

You've been working on a (Git) branch and you need to generate the list of files modified on that branch.

## Why?

GitHub shows it: it's useful to see in a PR. (maybe looking for surprises)

Maybe you need to run tests or a linter but it takes forever to run it for the whole codebase. Running
it on selected files makes it _a bit_ faster. (completely hypothetical! 😄)

## How Not to Do It..

First, I found all the commits on a branch, _manually_.

Then I tried to `git log --name-only COMMIT1 COMMIT2` ... which was kind of close.

The list of files was there ... now I needed to grep it out of the output. I also needed to remove duplicates (with `sort | uniq` or [awk](https://blog.jpalardy.com/posts/unsorted-uniq/)).

Bottom line: long, error-prone, and messy.

## A Better Way

> First, I found all the commits on a branch, _manually_.

Let's skip that step, I'll come back to it in a moment.

I didn't know that `git diff` also has the `--name-only` flag!

{% highlight bash %}
# git diff --name-only <commit> <commit>
> git diff --name-only fc5ca53 origin/evaluate-quantile-libs
Gopkg.lock
Makefile
README.md
attack.go
internal/cmd/jsonschema/main.go
lib/metrics.go
lib/metrics_test.go
lib/target.schema.json
lib/targets.go
lib/targets_test.go
>
{% endhighlight %}

Yes! Just the files, without duplicates.

What about "finding all the commits?" I found it at the [usual place](https://stackoverflow.com/questions/1549146/git-find-the-most-recent-common-ancestor-of-two-branches).

{% highlight bash %}
# git merge-base <commit> <commit>
> git merge-base master origin/evaluate-quantile-libs
fc5ca537bf4f01de94b0458729f455289351397e
>
{% endhighlight %}

Let's double-check `git log --graph`:

[![git log --graph confirms commit SHAs]({{site.url}}/assets/branch-modified-files/merge-base.png)]({{site.url}}/assets/branch-modified-files/merge-base.png)
(_click to enlarge_)

Looks right: `man git-merge-base` says:

> Find as good common ancestors as possible for a merge

## All Together

With [command substitution](https://www.gnu.org/software/bash/manual/html_node/Command-Substitution.html), it's possible to combine both commands on one line:

{% highlight bash %}
# git diff --name-only $(git merge-base <commit> <commit>) <commit>
> git diff --name-only $(git merge-base master origin/evaluate-quantile-libs) origin/evaluate-quantile-libs
Gopkg.lock
Makefile
README.md
attack.go
internal/cmd/jsonschema/main.go
lib/metrics.go
lib/metrics_test.go
lib/target.schema.json
lib/targets.go
lib/targets_test.go
>
{% endhighlight %}

That's a bit tedious, you can use `HEAD` if you're already on the branch:

{% highlight bash %}
# git diff --name-only $(git merge-base <commit> <commit>) <commit>
> git diff --name-only $(git merge-base master HEAD) # <- implicit HEAD
# omitted -- but same output!
>
{% endhighlight %}

and if `master` is the usual reference branch, you can automate it all:

{% highlight bash %}
# define a function:
> git-mod-files() {
>   git diff --name-only $(git merge-base ${1:-master} HEAD)
> }
> git-mod-files                        # defaults to master
# omitted -- but same output!
> git-mod-files origin/inline-body     # can specify a different branch
.github/CODEOWNERS
Gopkg.lock
Makefile
README.md
attack.go
internal/cmd/jsonschema/main.go
lib/metrics.go
lib/metrics_test.go
lib/target.schema.json
lib/targets.go
lib/targets_test.go
>
{% endhighlight %}

## Addendum

After I wrote this, I received an email from Nathan who pointed out there's a simpler way to do this.

As per `man git-diff`:

{% highlight text %}
git diff [<options>] <commit>...<commit> [--] [<path>...]
This form is to view the changes on the branch containing and up to
the second <commit>, starting at a common ancestor of both
<commit>. "git diff A...B" is equivalent to "git diff $(git
merge-base A B) B". You can omit any one of <commit>, which has the
same effect as using HEAD instead.

Just in case you are doing something exotic, it should be noted that
all of the <commit> in the above description, except in the last two
forms that use ".." notations, can be any <tree>.

For a more complete list of ways to spell <commit>, see "SPECIFYING
REVISIONS" section in gitrevisions(7). However, "diff" is about
comparing two endpoints, not ranges, and the range notations
("<commit>..<commit>" and "<commit>...<commit>") do not mean a range as
defined in the "SPECIFYING RANGES" section in gitrevisions(7).
{% endhighlight %}

If your eyes glazed over, the important part is:

    "git diff A...B" is equivalent to "git diff $(git merge-base A B) B".

That looks suspiciously close to what I came up with 🤔  
At least, I was on the right track...

{% highlight bash %}
# explicit: git diff --name-only master...HEAD
> git diff --name-only master...
Gopkg.lock
Makefile
README.md
attack.go
internal/cmd/jsonschema/main.go
lib/metrics.go
lib/metrics_test.go
lib/target.schema.json
lib/targets.go
lib/targets_test.go
>
{% endhighlight %}

Yep, looks good!
