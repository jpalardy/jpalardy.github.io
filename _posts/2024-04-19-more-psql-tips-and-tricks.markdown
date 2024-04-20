---
layout: post
title: More psql Tips and Tricks
category: posts
---

I wrote before about [psql Tips and Tricks](https://blog.jpalardy.com/posts/psql-tips-and-tricks/).  
This is more useful stuff I picked up since then.

Quick links:
- [pretty-printing JSONB](#pretty-printing-jsonb-columns)
- [better aggregate functions](#using-better-aggregate-functions)
- [format wrapped](#using-format-wrapped)

## Pretty-printing JSON(B) columns

In a query result, `JSONB` columns can be hard to read:

{% highlight text %}
> select asin, payload
  from imports
  where asin = '0486217094';

    asin    |                                      payload
------------+---------------------------------------------------------------------
 0486217094 | {"asin":"0486217094","title":"Basic Machines and How They Work","authors":["Naval Education And Training Program"],"pages":"128","published_on":"1994","isbn":"0486217094","dimensions":"6.4 x 0.3 x 9.3 inches"}
{% endhighlight %}

the [jsonb_pretty](https://www.postgresql.org/docs/current/functions-json.html) function really helps:

{% highlight text %}
> select asin, jsonb_pretty(payload) as payload
  from imports
  where asin = '0486217094';

    asin    |                                      payload
------------+---------------------------------------------------------------------
 0486217094 | {
            |     "asin": "0486217094",
            |     "isbn": "0486217094",
            |     "pages": "128",
            |     "title": "Basic Machines and How They Work",
            |     "authors": [
            |         "Naval Education And Training Program"
            |     ],
            |     "dimensions": "6.4 x 0.3 x 9.3 inches",
            |     "published_on": "1994"
            | }
{% endhighlight %}

Even if a column isn't strictly `JSONB`, you can usually cast, with `::jsonb`, to get what you want:

{% highlight text %}
> select asin, jsonb_pretty(to_json(username)::jsonb) as username
  from imports
  where asin = '0486217094';

    asin    | username
------------+--------------
 0486217094 | "jonathan"
{% endhighlight %}

## Using better aggregate functions

Consider this query:

{% highlight text %}
> select authors, pages
  from books
  where authors in ('Chalmers Johnson', 'Noam Chomsky')
  order by 1, 2 desc;

     authors      | pages
------------------+-------
 Chalmers Johnson |   400
 Chalmers Johnson |   368
 Chalmers Johnson |   288
 Chalmers Johnson |   224
 Noam Chomsky     |  2080
 Noam Chomsky     |   321
 Noam Chomsky     |   320
 Noam Chomsky     |   304
{% endhighlight %}

If there are MANY authors, maybe you would want to `group by`. Most aggregate functions (`sum`, `count`, `avg` ...) would _hide_ the actual `pages` values...

There are many options, but let's start with [string_agg](https://www.postgresql.org/docs/current/functions-aggregate.html)

{% highlight text %}
> select authors, string_agg(pages::text, ', ') as pages
  from books
  where authors in ('Chalmers Johnson', 'Noam Chomsky')
  group by 1
  order by 1, 2 desc;

     authors      |     pages
------------------+---------------------
 Chalmers Johnson | 288, 400, 368, 224
 Noam Chomsky     | 321, 320, 2080, 304
{% endhighlight %}

Not bad, but I had to cast the pages column from number to `::text` to make this work. Generally, you might reach for [array_agg](https://www.postgresql.org/docs/current/functions-aggregate.html) instead:

{% highlight text %}
> select authors, array_agg(pages) as pages
  from books
  where authors in ('Chalmers Johnson', 'Noam Chomsky')
  group by 1
  order by 1, 2 desc;

authors      |       pages
------------------+--------------------
Chalmers Johnson | {288,400,368,224}
Noam Chomsky     | {321,320,2080,304}
{% endhighlight %}

There are other exciting [aggregate functions](https://www.postgresql.org/docs/current/functions-aggregate.html) out there.

## Using format wrapped

For this section, we'll keep using the same query, but compare different viewing options.

{% highlight text %}
> select asin, isbn, authors, title
  from books
  where authors in ('Chalmers Johnson', 'Noam Chomsky')
  order by 1;

    asin    |    isbn    |     authors      |                                  title
------------+------------+------------------+-------------------------------------------------------------------------
 0805075593 | 0805075593 | Chalmers Johnson | Blowback, Second Edition: The Costs and Consequences of American Empire
 0805076883 | 0805076883 | Noam Chomsky     | Hegemony or Survival: Americas Quest for Global Dominance
 0805077979 | 0805077979 | Chalmers Johnson | The Sorrows of Empire: Militarism, Secrecy, and the End of the Republic
 0805082840 | 0805082840 | Noam Chomsky     | Failed States: The Abuse of Power and the Assault on Democracy
 0805087281 | 0805087281 | Chalmers Johnson | Nemesis: The Last Days of the American Republic
 0805093036 | 0805093036 | Chalmers Johnson | Dismantling the Empire: Americas Last Best Hope
 0887845746 | 0887845746 | Noam Chomsky     | Necessary Illusions: Thought Control in Democratic Societies
 B01AGIOEGG | NULL       | Noam Chomsky     | Who Rules the World?
{% endhighlight %}

What a wrapping mess ... but this is the default behavior in `psql`  
(i.e. `\pset format aligned`)

I recommended, in [better defaults](https://blog.jpalardy.com/posts/psql-tips-and-tricks/#better-defaults), using `\x auto` to fix that. It has its own charm:

{% highlight text %}
> \x auto

> select asin, isbn, authors, title
  from books
  where authors in ('Chalmers Johnson', 'Noam Chomsky')
  order by 1;

-[ RECORD 1 ]--------------------------------------------------------------------
asin    | 0805075593
isbn    | 0805075593
authors | Chalmers Johnson
title   | Blowback, Second Edition: The Costs and Consequences of American Empire
-[ RECORD 2 ]--------------------------------------------------------------------
asin    | 0805076883
isbn    | 0805076883
authors | Noam Chomsky
title   | Hegemony or Survival: Americas Quest for Global Dominance
-[ RECORD 3 ]--------------------------------------------------------------------
asin    | 0805077979
isbn    | 0805077979
authors | Chalmers Johnson
title   | The Sorrows of Empire: Militarism, Secrecy, and the End of the Republic
-- snip
{% endhighlight %}

Another (usually better) option is to use `\pset format wrapped`

{% highlight text %}
> \x off

> \pset format wrapped

> select asin, isbn, authors, title
  from books
  where authors in ('Chalmers Johnson', 'Noam Chomsky')
  order by 1;

    asin    |    isbn    |     authors      |                title
------------+------------+------------------+-------------------------------------
 0805075593 | 0805075593 | Chalmers Johnson | Blowback, Second Edition: The Costs.
            |            |                  |. and Consequences of American Empir.
            |            |                  |.e
 0805076883 | 0805076883 | Noam Chomsky     | Hegemony or Survival: Americas Que.
            |            |                  |.st for Global Dominance
 0805077979 | 0805077979 | Chalmers Johnson | The Sorrows of Empire: Militarism, .
            |            |                  |.Secrecy, and the End of the Republi.
            |            |                  |.c
 0805082840 | 0805082840 | Noam Chomsky     | Failed States: The Abuse of Power a.
            |            |                  |.nd the Assault on Democracy
 0805087281 | 0805087281 | Chalmers Johnson | Nemesis: The Last Days of the Ameri.
            |            |                  |.can Republic
 0805093036 | 0805093036 | Chalmers Johnson | Dismantling the Empire: Americas L.
            |            |                  |.ast Best Hope
 0887845746 | 0887845746 | Noam Chomsky     | Necessary Illusions: Thought Contro.
            |            |                  |.l in Democratic Societies
 B01AGIOEGG | NULL       | Noam Chomsky     | Who Rules the World?
{% endhighlight %}

This is _ESPECIALLY_ useful when dealing with multiple wide columns. `psql`
will try to fit each row to your screen's width.

It's not magic though; it's the HTML-table solution to formatting. Visually, you'll
know right away when it's not the right fit.

## All together

The good news is that these settings and functions are composable.

- `\pset format wrapped`
- `jsonb_pretty`
- `array_agg`

{% highlight text %}
> \pset format wrapped

> select authors, jsonb_pretty(to_json(array_agg(title))::jsonb) as titles
  from books
  where authors in ('Chalmers Johnson', 'Noam Chomsky')
  group by 1
  order by 1, 2 desc;

     authors      |                          titles
------------------+-----------------------------------------------------------
 Chalmers Johnson | [
                  |     "Blowback, Second Edition: The Costs and Consequences.
                  |. of American Empire",
                  |     "The Sorrows of Empire: Militarism, Secrecy, and the .
                  |.End of the Republic",
                  |     "Nemesis: The Last Days of the American Republic",
                  |     "Dismantling the Empire: America's Last Best Hope"
                  | ]
 Noam Chomsky     | [
                  |     "Who Rules the World?",
                  |     "Failed States: The Abuse of Power and the Assault on.
                  |. Democracy",
                  |     "Necessary Illusions: Thought Control in Democratic S.
                  |.ocieties",
                  |     "Hegemony or Survival: America's Quest for Global Dom.
                  |.inance"
                  | ]
{% endhighlight %}

Knowing what's possible is most of the work 😄

