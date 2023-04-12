---
layout: post
title: How to Export Excel Formulas to CSV
category: posts
---

Spreadsheets aren't my favorite things, but I've spent a decent amount of time
using them. A few weeks ago, I stumbled on a blind spot ... is there a way to
_EXPORT_ formulas?

## Looking At Formulas

You might already be familiar with this trick: `ctrl` `backtick` [^1] will toggle cells
between showing their values and their formulas:

[![toggling formulas back and forth](/assets/exporting-formulas/toggling.png)](/assets/exporting-formulas/toggling.png)

_⚠️  This works in Google Spreadsheet as well ⚠️_

This can really help making sense of things -- especially, if you're trying to eyeball a problem.

What's the alternative?  
Clicking on each cell and looking, _carefully_, at the formula bar?! 🤔

## Exporting Formulas?

If you're _REALLY_ trying to audit a spreadsheet and need to resort to
scripting, or other external tools -- it would be really useful if you could
export not the cell values, but their formulas instead.

Here's the trick:

- toggle to view the formulas (as described above)
- _NOW_, export to CSV

It was so easy ... I didn't think about it. 😄

I found this gem on [superuser.com](https://superuser.com/questions/466419/how-to-save-xls-x-as-csv-file-so-that-formulas-show-as-text).

<hr>

[^1]: [backtick](https://en.wikipedia.org/wiki/Backtick)? Probably to left of the `1` key on your keyboard, above the `tab` key

