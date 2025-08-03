---
layout: post
title: How to Cut a Rectangle into 3, without a Ruler
category: posts
---
## Background

[![obligatory lasagna](/assets/cut-in-3/lasagna-in-6.jpg)](https://thedashleyskitchen.com/lasagna-with-cottage-cheese/)

It wasn't my first time standing over a lasagna pan, trying
to eyeball how to cut it into 6 equal portions.

Cutting anything in 2 seems relatively easy to estimate. And, in the worst case, you can fall
back on [I cut, you choose](https://en.wikipedia.org/wiki/Divide_and_choose).

[![cut and choose example](/assets/cut-in-3/Cake_cutting_division.png)](/assets/cut-in-3/Cake_cutting_division.png)

What about cutting in 3? Eyeball it? Is there a better way?
- no rulers available
- but something like a [square](https://www.google.com/search?q=tool%20square&udm=2) to make straight lines and 90° angles
- as precise as possible, exact if possible

## Short version

<iframe width="560" height="315" src="https://www.youtube.com/embed/LCYBEIR4nwM?si=QAGbQ9LA07V6vEKq" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

## Warm up: how to divide in 2

[![divide in 2, illustrated](/assets/cut-in-3/divide-in-2.png)](/assets/cut-in-3/divide-in-2.png)

- red: diagonals to opposite corners, to find the middle
- green: perpendicular lines to the edges, through the middle
- only green lines matter

## How to divide in 3

This isn't "obvious"; take some time with it. I discuss my "shortcuts" in the next section.

[![divide in 3, illustrated](/assets/cut-in-3/divide-in-3.png)](/assets/cut-in-3/divide-in-3.png)

- same steps to red and green lines
- blue: from middle to opposite corners (here shown in 2 steps)
- green: forget the green lines, we won't need those anymore
- purple: through red-blue intersections, horizontally and vertically
- only purple lines matter

## What I actually do...

When, knife in hand, I try to cut in 3, I take some liberties 😆

[![divide in 3, roughly, illustrated](/assets/cut-in-3/divide-in-3-quick.png)](/assets/cut-in-3/divide-in-3-quick.png)

- I "imagine" the middle point of the top edge, by eye...
- I imagine the red and blue line, by eye...
- I mark the intersection
- I cut down horizontally/vertically through that point, depending on what I need

But ... what about the rest?!

The right side is 2/3 and I can divide that in halves by eyeball. (it's the same situation on the way down)

## What's the point of this?

Mostly, I was curious about finding an exact method.

This definitely works, but I couldn't find a great explanation. I tried to find a geometrical proof but I was stumped. In the end,
I solved for the intersection using the slopes of the lines.

- if W is the width of the rectangle
- if H is the height of the rectangle
- if the bottom-left side of rectangle is (0,0)
- red line: `y = -H/W x + H`
- blue line: `y = 2H/W x`
- solved in [Wolfram Alpha](https://www.wolframalpha.com/input?i=-%28H%2FW%29*x+%2B+H+%3D+%282H%2FW%29*x)

If you need to be precise, don't skip any steps -- but you decide how exacting your in-the-moment requirements are.

## Bonus

This technique also works in perspective (!)

<iframe width="560" height="315" src="https://www.youtube.com/embed/g7IftGoFJXk?si=QzUrBromfeyd96_f" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

Do you recognize the line work?


