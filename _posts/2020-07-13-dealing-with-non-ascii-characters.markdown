---
layout: post
title: Dealing with Non-ASCII Characters
category: posts
date: 2020-07-13 00:09 -0500
---
## Problem

Quick: why is this JSON not valid?

```text
{
  “user”: {
    “username”: “jpalardy”,
    “first_name”: “Jonathan”,
    “last_name”: “Palardy”
  }
}
```

<details>
  <summary>[reveal the answer]</summary>

  <br>

  <p>
  <a href="https://typographyforlawyers.com/straight-and-curly-quotes.html">Curly quotes!</a>
  </p>

  <p>
  Trick question? Yes and no... this happened to me and it was difficult to troubleshoot <em>visually</em>.
  </p>
</details>


## A Class of Problems...

Many text formats, programming languages and other machine-parsed texts have rules about
what characters are allowed and not.

When in doubt, the lowest common denominator is usually [ASCII](https://en.wikipedia.org/wiki/ASCII):

```text
The decimal set:

  0 nul    1 soh    2 stx    3 etx    4 eot    5 enq    6 ack    7 bel
  8 bs     9 ht    10 nl    11 vt    12 np    13 cr    14 so    15 si
 16 dle   17 dc1   18 dc2   19 dc3   20 dc4   21 nak   22 syn   23 etb
 24 can   25 em    26 sub   27 esc   28 fs    29 gs    30 rs    31 us
 32 sp    33  !    34  "    35  #    36  $    37  %    38  &    39  '
 40  (    41  )    42  *    43  +    44  ,    45  -    46  .    47  /
 48  0    49  1    50  2    51  3    52  4    53  5    54  6    55  7
 56  8    57  9    58  :    59  ;    60  <    61  =    62  >    63  ?
 64  @    65  A    66  B    67  C    68  D    69  E    70  F    71  G
 72  H    73  I    74  J    75  K    76  L    77  M    78  N    79  O
 80  P    81  Q    82  R    83  S    84  T    85  U    86  V    87  W
 88  X    89  Y    90  Z    91  [    92  \    93  ]    94  ^    95  _
 96  `    97  a    98  b    99  c   100  d   101  e   102  f   103  g
104  h   105  i   106  j   107  k   108  l   109  m   110  n   111  o
112  p   113  q   114  r   115  s   116  t   117  u   118  v   119  w
120  x   121  y   122  z   123  {   124  |   125  }   126  ~   127 del

(courtesy of `man ascii`, a reference never too far)
```

And while "curly quotes" might seem like a made-up problem[^made-up], there are other insidious examples:

- [en dash](https://en.wikipedia.org/wiki/Dash#En_dash), [em dash](https://en.wikipedia.org/wiki/Dash#Em_dash)
- [non-breaking space](https://en.wikipedia.org/wiki/Non-breaking_space) and [tab](https://en.wikipedia.org/wiki/Tab_key#Tab_characters) (to a lesser extent)
- [carriage return](https://en.wikipedia.org/wiki/Carriage_return) and [newline](https://en.wikipedia.org/wiki/Newline)
- in general: [homoglyphs](https://en.wikipedia.org/wiki/Homoglyph) ([other examples](https://en.wikipedia.org/wiki/IDN_homograph_attack))

## Solutions

There is no general solution to all the problems, only an assortment of tricks:

- "weird spacing" is often flagged or fixed by text editors; details will vary
- file formats: can be fixed with [dos2unix](https://waterlan.home.xs4all.nl/dos2unix.html) or similar
- external linters can be your sanity check:

{% highlight bash %}
> jq . invalid.json
parse error: Invalid numeric literal at line 2, column 13
>
# better than nothing? 🤔
{% endhighlight %}

### The Non-Visible ASCII regexp Trick

If what's allowed is "visible ASCII", what's _not allowed_ is "non-visible ASCII":

```
[^ -~]
```

described in words: all characters not between "space" and "tilde"  
(I don't remember where I picked up this trick. I would appreciate a link if you know.)

Why does this work? Referring back to the ASCII table from above:

```text
  0 nul    1 soh    2 stx    3 etx    4 eot    5 enq    6 ack    7 bel
  8 bs     9 ht    10 nl    11 vt    12 np    13 cr    14 so    15 si
 16 dle   17 dc1   18 dc2   19 dc3   20 dc4   21 nak   22 syn   23 etb
 24 can   25 em    26 sub   27 esc   28 fs    29 gs    30 rs    31 us
     /--- start here
 32 sp    33  !    34  "    35  #    36  $    37  %    38  &    39  '
 40  (    41  )    42  *    43  +    44  ,    45  -    46  .    47  /
 48  0    49  1    50  2    51  3    52  4    53  5    54  6    55  7
 56  8    57  9    58  :    59  ;    60  <    61  =    62  >    63  ?
 64  @    65  A    66  B    67  C    68  D    69  E    70  F    71  G
 72  H    73  I    74  J    75  K    76  L    77  M    78  N    79  O
 80  P    81  Q    82  R    83  S    84  T    85  U    86  V    87  W
 88  X    89  Y    90  Z    91  [    92  \    93  ]    94  ^    95  _
 96  `    97  a    98  b    99  c   100  d   101  e   102  f   103  g
104  h   105  i   106  j   107  k   108  l   109  m   110  n   111  o
112  p   113  q   114  r   115  s   116  t   117  u   118  v   119  w
120  x   121  y   122  z   123  {   124  |   125  }   126  ~   127 del
                                              stop here ---/
```

What is before space? various non-visible characters...  
What is after tilde? `del`, but also _ALL other Unicode characters!_

Why is this useful? Many text editors can highlight based on regular expressions:

![curly quotes highlighted in vim](/assets/dealing-with-non-ascii/curlies-in-vim.png)  
(this is vim; use `:set hlsearch` to turn this on)

This trick works everywhere regular expressions work:

![curly quotes highlighted in grep](/assets/dealing-with-non-ascii/curlies-in-grep.png)

-------------------------------------------------

Footnotes:

[^made-up]: copy-and-paste from Google Doc, Slack ... and let's compare notes 😐

