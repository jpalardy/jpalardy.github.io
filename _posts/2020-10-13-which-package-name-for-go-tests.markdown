---
layout: post
title: Which Package Name for Go Tests?
category: posts
---
Imagine a simple Go project:

{% highlight text %}
.
├── go.mod
├── main.go
└── stats
    └── avg.go
{% endhighlight %}

No tricks:

[![content of all files](/assets/go-test-pkg-name/all-files.png)](/assets/go-test-pkg-name/all-files.png)
_click to enlarge_

You are about to create `stats/avg_test.go`: what is the right package name declaration for that file?

1. `package stats`
2. `package stats_test`

<details>
<summary>[reveal the answer]</summary>

<div style="margin: 10px; padding: 10px; border: 2px dotted #bbb">
<p>Both 1 and 2 are correct ⚠️ </p>

<p><em>BUT</em> they will work differently... (keep reading)</p>
</div>

</details>


## Urgh... What?

Here's what [Go in Action](https://www.amazon.com/dp/1617291781/) says:

> The convention for naming your package is to use the name  
> of the directory containing it. (p.40)

That's what most Go programmers would say. Keeping in mind:

- except for `main`

Here's another one for you:

- except for tests: a `_test` suffix can be added

You could be forgiven for not knowing this rule. In fact, I managed to spend
_years_ with Go without knowing this rule. In denial, I looked all through Go in Action and found:

> [...] the package name also ends with \_test. When the package name ends like
> this, the test code can only access exported identifiers. (p.226)

Ouch... never saw that. Or I never realized what it implied.  
Here's another gem from `go help test`:

> Test files that declare a package with the suffix "\_test" will be compiled
> as a separate package, and then linked and run with the main test binary.

## Thank you: testpackage

I talked about [golangci-lint](https://blog.jpalardy.com/posts/up-your-go-game-with-golangci-lint/)
before. On April 22, 2020, [testpackage](https://github.com/maratori/testpackage) was [added to golangci-lint](https://github.com/golangci/golangci-lint/pull/852). If you ran golangci-lint
on this project after you added a test, you would get:

[![testpackage error](/assets/go-test-pkg-name/use-stats_test.png)](/assets/go-test-pkg-name/use-stats_test.png)

First reaction: my tests run and pass, what do you want from me?!

Second reaction: "use stats\_test?" ... but that would mean putting the tests in a separate directory (named `stats_test`)?! 🤔

As it turns out, you _CAN_ use `package stats_test` while keeping the test file in the `stats` directory.

## Implications

Why would you want this? Why does `testpackage` nag you about this?

It's a matter of blackbox versus whitebox testing.

Using `stats` allows you to test lowercase functions; you're allowed to reach
for those because your tests live in the same package. In the code above, your
`stats` package can invoke `sum` even though other packages wouldn't be allowed
to.

Using `stats_test` places your test code _outside_ the `stats` package itself;
you're only allowed to invoke the "public"/uppercase functions. You can test
`stats.Mean` (but not just `Mean` ⚠️) because that's what you export and that's what client code would be
allowed to use.

In both cases, you keep the `_test.go` files in the same directory as the rest
of the package. File organization -wise, nothing has changed. Philosophically
speaking, you're taking a different stance on "the right way to test things".

If you still want to test lowercase functions but survive linting, you can suffix
your test file with `_internal_test.go`...

You can read [motivation](https://github.com/maratori/testpackage#motivation)
straight from the testpackage's README. I recommend the referenced articles if
you need more convincing.

## Thoughts

Is this a good thing or not? Personally, I have mixed feelings about this.

I love being able to test internal/helper functions. Other programming
languages don't necessarily have a great answer for this. Going through the
public interface often makes the tests more complicated and stateful...
(arguably, that's what blackbox proponents would like to address)

I dislike that's it's another exception to package naming, and an obscure one
at that... 😫 Learning about these often feels like preparing for trivia night.
Placing "public package tests" in a separate directory would have accomplished
the same goal without adding an exception.

Also, from the outside, you cannot tell if `_test.go` files are
internal/external tests. You have to open the test files to confirm
(probably depending on a per-project testing philosophy).

If this was more explicit, or more frequently discussed... it would be easier
to accept as "another quirk of Go". In the end, I haven't decided whether I
would embrace this ... or work around it:

{% highlight yaml %}
--
linters:
  disable:
    - testpackage
{% endhighlight %}

You can [read more on stackoverflow](https://stackoverflow.com/questions/19998250/proper-package-naming-for-testing-with-the-go-language).

