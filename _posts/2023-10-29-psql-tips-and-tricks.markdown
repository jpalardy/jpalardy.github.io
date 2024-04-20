---
layout: post
title: psql Tips and Tricks
category: posts
date: 2023-10-29 15:36 -0500
---

Quick links:
- [better defaults](#better-defaults)
- [variables](#variables)
- [temporary tables](#temporary-tables)

## Why psql?

[psql](https://www.postgresql.org/docs/current/app-psql.html) is a terminal-based front-end to PostgreSQL. It looks like this:

[![screenshot of psql](/assets/psql-tips-tricks/psql-ss.png)](/assets/psql-tips-tricks/psql-ss.png)

Why you would use `psql` when there are [so many other clients](https://wiki.postgresql.org/wiki/PostgreSQL_Clients) available? 🤔

My short answer is that, sooner or later [^1], you can end up on the wrong side of an `ssh` session, and `psql` is going to be all you've got.

It also doesn't hurt to learn a few tricks (or to bookmark this page).

This isn't a general `psql` tutorial: you can easily [find one elsewhere](https://www.google.com/search?q=psql+tutorial).

## Why I use psql

I use `psql` because:

1. I don't have to install anything else, which aligns with my minimalistic sensibilities
2. I combine it with [vim-slime](https://github.com/jpalardy/vim-slime), which seems to give me the best of all worlds

## Better defaults

Locally, I keep this config in my `$HOME/.psqlrc`

{% highlight text %}
\pset pager off
\pset null NULL
\x auto
{% endhighlight %}

When I'm on a remote machine, nothing prevents me from copy-pasting these 3 lines directly in `psql`.
What does it change?

`\pset pager off`

If a query scrolls off the page -- which doesn't take a lot -- you end up in
the pager with the `:` prompt. This allows you to scroll up/down ... but you
need to press `q` to return to the normal prompt. I _hate_ this default
behavior ... please let it scroll; and `pager off` does exactly that.

`\pset null NULL`

By default, `null` values look blank. With it, `null` will be shown as `NULL`. If you need something more obvious, you can use a different string:
- `(null)`
- `<null>`
- or [this](https://proinsias.github.io/til/PSQL-Pset-a-better-null-display-character/) 😄

`\x auto`

If you `SELECT` and the result is too wide, `psql` will wrap the text. That usually ends up looking pretty bad.

So, most people end up using `\x on`, which shows up vertically:

[![going vertical with x on](/assets/psql-tips-tricks/x-on.png)](/assets/psql-tips-tricks/x-on.png)

But with `\x on`, even a `SELECT` that _could_ fit will end up vertical (and harder to read) ... with `\x auto`, you will get
horizontal _UNLESS_ it's too wide.

[![back to horizontal with x auto](/assets/psql-tips-tricks/x-auto.png)](/assets/psql-tips-tricks/x-auto.png)

## Variables

Variables in `psql` can be as useful as variables anywhere else you use them. For example:

{% highlight sql %}
\set pages 100

-- use it:

SELECT ASIN, LEFT (title, 60)
FROM books
WHERE pages < :pages
ORDER BY inserted_at DESC
LIMIT 5;
{% endhighlight %}

[![SELECT with a variable](/assets/psql-tips-tricks/select-with-variable.png)](/assets/psql-tips-tricks/select-with-variable.png)

The main advantages of using variables in `psql`:
- write your query once
- no painful text editing of the SQL  
  (use the up arrow to rerun the same query)
- only change the variable value

One _gotcha_ for text variables: if your value needs to be "quoted", there's a special syntax for that: `:'varname'`

[![you need to quote text variables](/assets/psql-tips-tricks/quoted-var.png)](/assets/psql-tips-tricks/quoted-var.png)

## Temporary Tables

If variables are useful, temporary tables are an extension of that. You can capture multiple values in a
table and use them with the `IN` operator:

{% highlight sql %}
-- capture multiple values

DROP TABLE IF EXISTS results;
CREATE TEMPORARY TABLE results AS (
  SELECT ASIN FROM books WHERE pages < 75
);

-- then, later...

SELECT title
FROM books
WHERE ASIN in (SELECT * FROM results)
LIMIT 10;
{% endhighlight %}


[![SELECT using a temporary table](/assets/psql-tips-tricks/temp-table.png)](/assets/psql-tips-tricks/temp-table.png)

I didn't have many uses for `TEMPORARY TABLE` before I thought of this. But what's the impact of creating these temporary tables?
And when would they disappear?

> A temporary table, as its name implied, is a short-lived table that exists
for the duration of a database session. PostgreSQL automatically drops the
temporary tables at the end of a session or a transaction.

([reference](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-temporary-table/))

So, your temporary tables will garbage collect themselves when you quit `psql`.
They also live in a separate schema, so they won't be visible to other users.

## Addendum

I put down [More psql Tips and Tricks](https://blog.jpalardy.com/posts/more-psql-tips-and-tricks/) since this article.

<hr>

[^1]: Especially when things won't be going well...

