---
layout: post
title: Goodbye Git Master Branch
category: posts
---
Switching off the git `master` branch was easier than I expected!

## Changes are coming...

I had heard about the [controversy](https://www.zdnet.com/article/github-to-replace-master-with-alternative-term-to-avoid-slavery-references/)
about git's `master` branch. I didn't have a strong emotional attachment to the name... so I decided to switch and see what happens.

It seems like `main` is [the consensus](https://github.com/github/renaming#why-main) for the new branch name:
- it's short
- it's easy on muscle memory (has the same first 2 letters)
- it translates well to most languages

Let's switch everything to `main`.

## New Repositories, on GitHub

[Since October 2020](https://github.blog/changelog/2020-10-01-the-default-branch-for-newly-created-repositories-is-now-main/), GitHub creates new repositories with `main` as the default branch.

Done ✅

## New Repositories, locally

Since git 2.28, there's a [new config setting](https://github.blog/2020-07-27-highlights-from-git-2-28/) for the default branch name on
__newly__ created repositories:

{% highlight bash %}
> git config --global init.defaultBranch main
{% endhighlight %}

Done ✅

## Existing Repositories...

It took a few tries to find a recipe that I was happy with.

For each repository, pick one clone:

{% highlight bash %}
> git branch -m master main
> git push -u origin main
> git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main

# remote is github?
# - visit https://github.com/$username/$project/settings/branches
# it's under "settings" >> "branches"
# - rename default branch

# remote is bare repo?
# - cd to its directory
> git symbolic-ref HEAD refs/heads/main

# back to local directory
> git push origin --delete master
{% endhighlight %}

and for all your other clones:

{% highlight bash %}
> git branch -m master main
> git branch -u origin/main
{% endhighlight %}

I audited all my local repositories and had the chance to practice on over 20 projects. ✅

Then, I remembered to repeat on all my computers. ✅

## Your own local audit

If you've been accumulating clones over time, it's easy to lose track of _ALL_
the git repositories you have hanging around. This can be a good start:

{% highlight bash %}
# from your $HOME
> find . -name 'config' -type f 2>/dev/null | grep '\.git/config'
{% endhighlight %}

If you save the output to a file, you can bootstrap the next phase: checking "ownership"

{% highlight bash %}
# output from previous command, saved to "all_repos"
> grep github.com:jpalardy $(cat all_repos)
{% endhighlight %}

You'll want to adjust this to your own git remote names, usernames, etc

## Consequences

Everything _just worked_ ... which wasn't what I was expecting. I was planning on breaking something... researching and fixing problems over time. 😅

Intellectually, I understood that commits matter, but branches are just
convenient names. Of course, branches can have different names locally and remotely ... (although I never thought that would be a good idea)

## References

Sounds too easy? Not sure? Here are some of the pages that helped me:

- [Easily rename your Git default branch from master to main](https://www.hanselman.com/blog/easily-rename-your-git-default-branch-from-master-to-main)
- [github/renaming](https://github.com/github/renaming)
- [How to rename the "master" branch to "main" in Git](https://www.git-tower.com/learn/git/faq/git-rename-master-to-main/)
- [5 steps to change GitHub default branch from master to main](https://stevenmortimer.com/5-steps-to-change-github-default-branch-from-master-to-main/)

