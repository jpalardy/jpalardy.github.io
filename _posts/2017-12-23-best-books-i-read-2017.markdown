---
layout: post
title: "The Best Books I Read in 2017"
category: posts
---

I have read many books in 2017, but it wasn't all good. Some books, however,
deserve to be acknowledged. I broke down my recommendations by categories:
[technical](#technical), [non-fiction](#non-fiction) and [fiction](#fiction).
There is no particular order.

I have similar posts for [2015](https://blog.jpalardy.com/posts/best-books-i-read-2015/) and [2016](https://blog.jpalardy.com/posts/best-books-i-read-2016/).

-------------------------------------------------

## Technical

### How to Measure Anything

<a href="https://www.amazon.com/dp/1118539273/"><img class="book-cover" src="/assets/best-books-2017/1118539273.jpg" alt="How to Measure Anything" /></a>

"Anything can be measured." is how the book begins, the rest of the book
explains how to go about it.

When people say "it can't be measured", they often mean:

- we don't know how to measure it...
- we think it would cost too much to measure...
- we can't pinpoint its _exact_ value...  
(_in other words: there's always uncertainty_)

The first part of the book tries to convince you that measurements are
worthwhile. There is a way to measure what you need, it's cheaper than you
expect, and it gets you "close enough" to the truth.

The book also covers "what's a measurement?", what you can measure _versus_ what you should
measure, how to reduce uncertainty, the cost/value of more information, a
long list of cognitive biases to consider, etc.

If you're familiar with [Fermi problems](https://en.wikipedia.org/wiki/Fermi_problem), this book
will cover and expand the technique:

- estimate something: give it a range (rather than [the alternative](https://blog.jpalardy.com/posts/reject-summary-statistics/))
- adjust the range so that you're 90% confident it contains the real value -- the book gives you techniques to do that
- assume a specific distribution (linear, normal, other?)
- each estimate chains into the next

If you simulate the above, you get the [Monte Carlo method](https://en.wikipedia.org/wiki/Monte_Carlo_method).
It doesn't have to be complicated; you can run this in a spreadsheet. The [book's website](http://www.howtomeasureanything.com/) provides
spreadsheet templates to get you started.

Don't accept "it can't be measured" from people who haven't read this book.

* [amazon](http://www.amazon.com/dp/1118539273/)
* [website](http://www.howtomeasureanything.com/how-to-measure-anything-third-edition/)


### High Performance Browser Networking

<a href="https://www.amazon.com/dp/1449344763/"><img class="book-cover" src="/assets/best-books-2017/1449344763.jpg" alt="High Performance Browser Networking" /></a>

It's easy to take for granted all the technologies required to make web
development possible. We learn what we need, pick up more over time, but we
rarely resort to the depths provided by this book.

The book is divided into parts:

- low level: latency, bandwidth, TCP, UDP, TLS
- wireless networks: WiFi and mobile networks
- HTTP: 1.x, 2.x and optimizations
- APIs and protocols: XHR, SSE, WebSocket, WebRTC

It covers _a lot_. Most of it was a review, but I was grateful to
get it all in one place. The author's style is clear; it was a joy to read.
I think this book has a place in a modern technical bookshelf.

* [amazon](http://www.amazon.com/dp/1449344763/)
* [website](https://hpbn.co/)


### Designing Data-Intensive Applications

<a href="https://www.amazon.com/dp/1449373321/"><img class="book-cover" src="/assets/best-books-2017/1449373321.jpg" alt="Designing Data-Intensive Applications" /></a>

There was a lot of buzz when this book came out. It's all justified.

This is a survey of theories, tools, and techniques. It takes so many topics and
explains them so well -- it would take months of research to get the content
from other sources. Case in point: there's an extensive bibliography for _each chapter_!

Whenever I've had to talk about system design since I've read it, I was
grateful to have read this book. There is no right answer, but you develop a
sense of the trade-offs involved in different solutions. You get a better idea
of what questions to ask and what to look for.

It also gave me an appreciation for all the ways that things can go wrong
with distributed systems. It's a wonder that anything works...

* [amazon](http://www.amazon.com/dp/1449373321/)
* [website](https://dataintensive.net/)


### R for Data Science

<a href="https://www.amazon.com/dp/1491910399/"><img class="book-cover" src="/assets/best-books-2017/1491910399.jpg" alt="R for Data Science" /></a>

This is the book I wish I had when I started out learning R.

Back then, there were _few_ books and _fewer_ good books. Nowadays, the
situation has improved significantly. However...

There is "old R" and "new R" out there. Old R is what we've had
since the beginning, usually denoted with `*apply` functions and the base
graphics package. There's nothing wrong with old R ... but it's neither
easy to learn nor easy to use. When authors talk about it, the explanations are full of apologies...

Meanwhile, the [tidyverse](https://www.tidyverse.org/) is what most people
are using now. It's a modern twist on R coming from the open-source community.
The tidyverse is just an opinionated list of packages including:

- `ggplot2` -- the "killer app" of R, in my opinion
- `dplyr` -- select/filter/order functions for data frames / tibbles
- `tibble` -- a friendly replacement for data frames
- `magrittr` -- like `|` on the command-line
- [and more...](https://www.tidyverse.org/packages/)

Instead of choosing and loading these packages separately, loading `tidyverse`
will load them all for you. If you tell me you use the tidyverse, I know
exactly what packages you use.

On top of walking you through the tidyverse, you also get plenty of advices on
how to organize and analyze data for your "data science" projects -- but really
any project with data.

* [amazon](http://www.amazon.com/dp/1491910399/)
* [website](http://r4ds.had.co.nz/)


-------------------------------------------------

## Non-Fiction

### The Dictator's Handbook

<a href="https://www.amazon.com/dp/1610391845/"><img class="book-cover" src="/assets/best-books-2017/1610391845.jpg" alt="The Dictator's Handbook" /></a>

A powerful, if depressing, book.

This was a [CGP grey](https://en.wikipedia.org/wiki/CGP_Grey) recommendation at the end of
his excellent video series called: [Rules for Rulers](https://www.youtube.com/watch?v=rStL7niR7gs&list=PLqs5ohhass_QPOfhvhIzxas3Vr9k31Vaz).
Good news: the videos alone will give you 90% of the ideas from the book.

If you accept the premise of the book, you get a framework to understand political behaviors:

- why revolutionaries end up betraying each other
- why corruption makes sense
- why foreign aid is _complicated_

This book provides tremendous explaining power.

Personally, I went from "politics doesn't make sense" to understanding why
politicians do what they do.

Not everybody agrees with the political theory of the book. But I think theories
can be judged based on _how much_ they can explain simply.

* [amazon](http://www.amazon.com/dp/1610391845/)
* [wikipedia](https://en.wikipedia.org/wiki/The_Dictator%27s_Handbook)
* [website](https://www.hachettebookgroup.com/titles/bruce-bueno-de-mesquita/the-dictators-handbook/9781610390453/)


### Weapons of Math Destruction

<a href="https://www.amazon.com/dp/0553418815/"><img class="book-cover" src="/assets/best-books-2017/0553418815.jpg" alt="Weapons of Math Destruction" /></a>

_Weapons of Math Destruction_ is a sobering critique of the (careless) use of algorithms.

Earlier this year, I also read [The Master Algorithm](http://www.amazon.com/dp/0465065708/)
which reads more like a love story. Short version: The Master Algorithm didn't
make this list. I thought it was techno-optimism: a celebration of current and
coming achievements with a don't-worry-about-it perspective about possible
shortcomings.

The book documents instances of systematic discrimination coming from "black
box" algorithms. We know that [humans are biased](https://en.wikipedia.org/wiki/List_of_cognitive_biases)
... but [algorithms are biased too](https://www.youtube.com/watch?v=_2u_eHHzRto).
Trust in algorithms we don't understand, applied wholesale to a variety of
problems, without recourse when things go wrong, provide a dystopian view of
things to come.

Whether statisticians or programmers, it is up to us to push back on misguided
applications of algorithms, big data, and machine learning. If we don't, the
coming backlash might be justified.

* [amazon](http://www.amazon.com/dp/0553418815/)
* [wikipedia](https://en.wikipedia.org/wiki/Weapons_of_Math_Destruction)
* [website](https://weaponsofmathdestructionbook.com/)


-------------------------------------------------

## Fiction

### We Are Legion

_Series: 3 books, complete._

<a href="https://www.amazon.com/dp/B01L082SCI/"><img class="book-cover" src="/assets/best-books-2017/B01L082SCI.jpg" alt="We Are Legion" /></a>

"We are legion. We are Bob", really? I didn't even judge the book by its cover;
the uninspiring title was enough for me. But I read the glowing reviews and decided to give it a try.

I loved the beginning: it reminded me of [Old Man's War](http://www.amazon.com/dp/0765348276/);
you discover the story, and the rules, at the same time the main character does.

I thought the second and third books weren't as good, maybe even episodic. There
was too much to keep track of. And the ending wasn't satisfying... But, despite my
complaints, I couldn't put it down until the end.

* [amazon](http://www.amazon.com/dp/B01L082SCI/)
* [website](http://dennisetaylor.org/legion/)


### Expeditionary Force

_Series: 5 books, ongoing._

<a href="https://www.amazon.com/dp/B01MQR08XA/"><img class="book-cover" src="/assets/best-books-2017/B01MQR08XA.jpg" alt="Expeditionary Force" /></a>

This falls under the category of "military sci-fi", a place I hadn't spent a
lot of time in and wasn't planning on visiting soon. Once again, the reviews pulled me in.

This isn't a series that takes itself seriously. Is
military-goofy sci-fi a genre? Earth is in danger, aliens are involved, our
enemies aren't who we think they are, etc. How can this be a comedy?!
I don't want to spoil anything, pick it up and get back to me.

Is it a masterpiece? No. Will I buy the next book when it comes out? Yes,
definitely.

* [amazon](https://www.amazon.com/dp/B01MQR08XA/)
* [website](https://www.craigalanson.com/books/)


### Fear the Sky

_Series: 3 books, complete._

<a href="https://www.amazon.com/dp/B00S8FPDQA/"><img class="book-cover" src="/assets/best-books-2017/B00S8FPDQA.jpg" alt="Fear the Sky" /></a>

In contrast to the books above, the _Fear Saga_ series is a darker
type of sci-fi. It has _some_ aspects of the [Three-Body Problem](http://www.amazon.com/dp/0765377063/)
which I [reviewed previously](https://blog.jpalardy.com/posts/best-books-i-read-2015/#the-three-body-problem).

Aliens are coming and ... it's complicated. Let me spare you the spoilers.
The first book is a thriller; there is so much at stake, so much to fear, and so many opportunities to fail.

The second and third books didn't have quite the tension of the first, but they
were enjoyable nonetheless. I was able to digest the [deus ex machina](https://en.wikipedia.org/wiki/Deus_ex_machina)
ending because the reviews had warned me in advance.

Not perfect, but pretty good.

* [amazon](http://www.amazon.com/dp/B00S8FPDQA/)
* [website](http://www.thefearsaga.com/)


-------------------------------------------------

## Closing Thoughts

If you have liked this blog post, please write your own. I want to read your book
reviews and recommendations.

