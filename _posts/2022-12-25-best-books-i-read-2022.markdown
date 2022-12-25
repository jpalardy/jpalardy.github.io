---
layout: post
title: The Best Books I Read in 2022
category: posts
---
I have read many books in 2022; let's forget most and talk about the good ones.

There is no particular order, but I broke down my recommendations by
categories: [technical](#technical), [non-fiction](#non-fiction) and
[fiction](#fiction).

This is a yearly tradition! You can read my book reviews from previous years:  
[2015](https://blog.jpalardy.com/posts/best-books-i-read-2015/) [2016](https://blog.jpalardy.com/posts/best-books-i-read-2016/) [2017](https://blog.jpalardy.com/posts/best-books-i-read-2017/) [2018](https://blog.jpalardy.com/posts/best-books-i-read-2018/) [2019](https://blog.jpalardy.com/posts/best-books-i-read-2019/) [2020](https://blog.jpalardy.com/posts/best-books-i-read-2020/) and [2021](https://blog.jpalardy.com/posts/best-books-i-read-2021/).

---

## Technical

### Domain Modeling Made Functional

<a href="https://www.amazon.com/dp/1680502549/"><img class="book-cover" src="/assets/best-books-2022/1680502549.jpg" alt="Domain Modeling Made Functional" /></a>

If you wanted to learn how to do object-oriented design, there are many books
out there (_though none that I can recommend; that's a different topic_).
However, when it comes to functional programmning, where do you even start?

This book exceeded my expectations:
- it's easy to read
- it's practical
- it covers functional architecture
- it dives deep on types

I had already heard about the book before. Then I stumbled on this fantastic video from the author:

<iframe width="560" height="315" src="https://www.youtube.com/embed/Up7LcbGZFuo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

<br>
I love this slide:

[![picture from video: how many things are wrong with this design](/assets/best-books-2022/things-wrong.png)](/assets/best-books-2022/things-wrong.png)

(spoiler: so many things...)

I've heard some people complain about F#, but I didn't think it was a big problem.

I only wish Scott Wlaschin would write more books, so that I could read those too...

- book: [amazon](https://www.amazon.com/dp/1680502549/)
- book: [pragprog](https://pragprog.com/titles/swdddf/domain-modeling-made-functional/)
- author: [website](https://fsharpforfunandprofit.com/books/)

<!-- ------------------------------------------------- -->

### Property-Based Testing with PropEr, Erlang, and Elixir

<a href="https://www.amazon.com/dp/1680506218/"><img class="book-cover" src="/assets/best-books-2022/1680506218.jpg" alt="Property-Based Testing with PropEr, Erlang, and Elixir" /></a>

The premise of property-based testing is intriguing: writing _less_ tests but getting _better_ coverage.

It forces you to think about your functions; what are the properties of a sorting function?

- obviously: output is sorted (need another function to check `is_sorted`?)
- output list same length as input list
- output contains _only_ elements from the input
- duplicates sorting is [stable](https://en.wikipedia.org/wiki/Category:Stable_sorts)? (depending on your requirements)

Currently, it's the only book that covers the topic; your alternatives might be blog
posts and documentation pages. And though this book covers Erlang/Elixir, its
lessons are broadly applicable to other languages and frameworks.

At a high level, it generates random inputs -- albeit meaningful ones, this
isn't [fuzzing](https://en.wikipedia.org/wiki/Fuzzing) -- and explores the
problem space automatically. Meanwhile, example-based testing often depends on
hardcoded values, which makes me wonder "does this value mean something?". And
if it doesn't, it might be better to generate one (e.g. [faker](https://fakerjs.dev/)).

Property-based testing is perfect for functional code, but it's useful for
stateful properties too (it's covered later in the book). Imagine generating
random "scenarios" from list of actions your users might perform. Check out
David Nolen's [The Power of Toys](https://youtu.be/qDGTxyIrKJY?t=1914) to get a
better idea.

In the end, it's not right for every project and you need to consider your
team/audience. But even when I don't use property-based testing, it's changed
the way I test: I write more parametrized tests and try to randomize all the
things that aren't supposed to matter.

- book: [amazon](https://www.amazon.com/dp/1680506218/)
- book: [pragprog](https://pragprog.com/titles/fhproper/property-based-testing-with-proper-erlang-and-elixir/)
- author: [website](https://ferd.ca/)


---

## Non-Fiction

### Ducks

<a href="https://www.amazon.com/dp/1770462899/"><img class="book-cover" src="/assets/best-books-2022/1770462899.jpg" alt="Ducks" /></a>

I didn't know much about this book before I started reading it. I already knew
the author from her previous work, and the early recommendations closed
the deal.

This is a _weird_ book to describe: it's a graphic novel, it's autobiographical
and has a flavor of [slice of life](https://en.wikipedia.org/wiki/Slice_of_life).
It is as the alternate title says: "Two Years in the Oil Sands".

It is at times funny ... but it's _mostly_ sad. It touches a variety of
societal problems in a deeply personal way. It is a kind of documentary,
without an _obvious_ agenda. It is more **demanding**: it shows you and asks you to
reach your own conclusions.

It takes you on a journey. At some point, towards the end, I felt _different_.

Thank you for this book, Kate.

(_Disclaimer: without going into details, bad things happen in Alberta._)

- book: [amazon](https://www.amazon.com/dp/1770462899/)
- book: [wikipedia](https://en.wikipedia.org/wiki/Ducks:_Two_Years_in_the_Oil_Sands)
- book: [website](https://drawnandquarterly.com/books/ducks/)
- author: [wikipedia](https://en.wikipedia.org/wiki/Kate_Beaton)

<!-- ------------------------------------------------- -->

### Soft City

<a href="https://www.amazon.com/dp/1642830186/"><img class="book-cover" src="/assets/best-books-2022/1642830186.jpg" alt="Soft City" /></a>

I found this book on [Jonathan New's blog](https://blog.jonnew.com/posts/books-i-read-2020).
It sounded like something I would enjoy reading. (Thanks Jon!)

**Soft City** is filled with beautiful images; it's pornography for people who
love urbanism. Everyday, for the month I spent reading it, it
was something that I looked forward to.

Depending on where you live, what is described in this book is normal ... or pure fantasy. It covers a
lot of the same ground that [Not Just Bikes](https://www.youtube.com/@NotJustBikes) does.

A "soft" city is:
- human scale
- comfortable
- walkable
- multifunctional

The opposite is probably ... a suburb: a place where the next thing you want to
do starts with a car ride. If you've been to Europe or Japan, you already know
that there are other ways to live.

- book: [amazon](https://www.amazon.com/dp/1642830186/)
- book: [website](https://islandpress.org/books/soft-city)
- author: [website](https://gehlpeople.com/people/david-sim/)

<!-- ------------------------------------------------- -->

### The Effective Manager

<a href="https://www.amazon.com/dp/1119244609/"><img class="book-cover" src="/assets/best-books-2022/1119244609.jpg" alt="The Effective Manager" /></a>

No, I am not a manager.

But I stumbled on a [hacker news thread](https://news.ycombinator.com/item?id=32790064) about "Which books do
you consider real gems in your field of work/study?" The reviews were glowing.

> All the things that no one says or tells about management and communication.

Right in the introduction, I was struck by:

> Hundreds, if not thousands, of managers describe their "training" this way: I
> got promoted, and they didn't tell me anything about what I was supposed to
> do or how I was supposed to do it.

I know many people who went through this exact experience; with various results...

The book asks "What is the definition of a good manager?" And tells you all the
wrong answers first 😄 (no, I didn't guess correctly either...)

You'll be guided through the 2 _real_ responsibilities of managers. Then you'll
be explained the 4 critical behaviors and, specifically, _HOW_ to apply them to
your team.

There's more good news:

- it's a thin book, around 200 pages
- it's "front loaded", the book starts with the most important content
- it's no-nonsense; straight talk for people who want it

Even if you're not a manager, it gives you better soft skills and better tools
to cooperate with your teammates.

- book: [amazon](https://www.amazon.com/dp/1119244609/)
- book: [website](https://www.wiley.com/en-us/The+Effective+Manager-p-9781119244608)
- author: [website](https://www.manager-tools.com/)

<!-- ------------------------------------------------- -->

### The End of the World Is Just the Beginning

<a href="https://www.amazon.com/dp/006323047X/"><img class="book-cover" src="/assets/best-books-2022/006323047X.jpg" alt="The End of the World Is Just the Beginning" /></a>

(Thanks to Grof for this recommendation!)

In many ways, this book _defined_ my 2022. I devoured it; then I read Zeihan's 3
other books. I subscribed to his YouTube channel. I couldn't get enough.

This book so changed how I think about the world that I can barely discuss the news
without bringing up Zeihan or his books.

As a child of an unprecedented era of prosperity (and relative peace), I never
_really_ thought that not all countries have everything they need to succeed
(or even survive).

This book gave me enough context to understand geopolitics:
- where countries are (_it matters!_)
- what good and bad things they have going for them
- how these things affect their destiny, their options, and their relationship with other countries

So many things suddenly made sense!

The writing is fresh and funny. I think his last book is the best of the bunch.
If you're not convinced, try his YouTube channel first.

- book: [amazon](https://www.amazon.com/dp/006323047X/)
- book: [website](https://zeihan.com/end-of-the-world/)
- author: [wikipedia](https://en.wikipedia.org/wiki/Peter_Zeihan)
- author: [youtube](https://www.youtube.com/c/ZeihanonGeopolitics)

---

## Fiction

### Project Hail Mary

<a href="https://www.amazon.com/dp/B08GB58KD5/"><img class="book-cover" src="/assets/best-books-2022/B08GB58KD5.jpg" alt="Project Hail Mary" /></a>

This is ... a flawed book. 😬

I found the characters _simple_. I found the dialogues unrealistic. I found all
kind of "side trips" that an editor might have wanted to cut.

Also, in many ways, it's a repeat of [The Martian](https://www.amazon.com/dp/0553418025/):
- single guy stranded in space
- going to [science the shit out of](https://www.google.com/search?q=science+the+shit+out+of+this&tbm=isch) every problems

And I have read [Artemis](https://www.amazon.com/dp/B0721NKNHR/) and thought it was nothing special.

But ........ **despite** all this, it passes the most important test: I wanted to
keep reading and find out what was going to happen next.

Now that I've adjusted your expectations, I think you'll be able to enjoy this book too.

- book: [amazon](https://www.amazon.com/dp/B08GB58KD5/)
- book: [wikipedia](https://en.wikipedia.org/wiki/Project_Hail_Mary)
- author: [wikipedia](https://en.wikipedia.org/wiki/Andy_Weir)
- author: [website](https://andyweirauthor.com/)

<!-- ------------------------------------------------- -->

### A Memory Called Empire

<a href="https://www.amazon.com/dp/B07PWHQW1F/"><img class="book-cover" src="/assets/best-books-2022/B07PWHQW1F.jpg" alt="A Memory Called Empire" /></a>

This book kept popping up on Audible and I became curious. But some of the
criticism was _harsh_ and it's been a challenge to decide which reviews to take
seriously and which to ignore.

In the end, it didn't hurt that it won the 2020 [Hugo award](https://en.wikipedia.org/wiki/Hugo_Award_for_Best_Novel) for best novel.

Who knew that I would find a political thriller _delightful_? I loved listening to
intelligent conversations: everything that was said, and everything that wasn't...

It starts as a murder mystery (kind of) but goes in different directions.
You're the outsider and there's a lot to learn: the city, the empire, the
players and the stakes. Things happen fast and there's always something else coming.

I found the ending bittersweet. And I found the sequel, [A Desolation Called Peace](https://www.amazon.com/dp/B082WK914S/), good
but ... smaller too. It's hard to explain. (maybe it closed too many story lines? 🤔)

This might not be for everyone, but it worked for me.

- book: [amazon](https://www.amazon.com/dp/B07PWHQW1F/)
- book: [wikipedia](https://en.wikipedia.org/wiki/A_Memory_Called_Empire)
- author: [wikipedia](https://en.wikipedia.org/wiki/Arkady_Martine)
- author: [website](https://www.arkadymartine.net/)

---

## Closing Thoughts

If you have liked this blog post, please write your own. I would love to read your book
reviews and recommendations.

