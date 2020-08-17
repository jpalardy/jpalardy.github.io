---
layout: post
title: 'Chrome Extension: Click to Remove Element'
category: posts
---
For years, I _customized_ web pages by opening up `Developer Tools`, looking
for the right DOM elements and deleting them. Classic cases include:

- leftover ads
- annoying GIF images
- modal popups
- "Accept cookies" banners
- helpers "share" toolbars
- excessive headers/footers

## Click to Remove Element

I had reached a point where I wished I could "right-click, delete"
on anything on a page. (without opening a console) I went looking and found:
[Click to Remove Element](https://chrome.google.com/webstore/detail/click-to-remove-element/jcgpghgjhhahcefnfpbncdmhhddedhnk).

It does exactly what it says it does 😃

You get a toolbar icon (and a keyboard shortcut: cmd-shift-x) ... and if you
click on something, it gets removed. Straight from the website, the examples
are simple but compelling.

Remove images:

![example removing an annoying gif]({{site.url}}/assets/click-to-remove-element/annoying-gif.jpg)

Remove navigation:

![example removing an annoying nav]({{site.url}}/assets/click-to-remove-element/annoying-nav.jpg)

Remove ads:

![example removing an annoying ad]({{site.url}}/assets/click-to-remove-element/annoying-ad.jpg)

Not shown above, but important, there's a helper popup (browser bottom-right) that shows the HTML path:

![helper popup in action]({{site.url}}/assets/click-to-remove-element/helper-popup.png)

As indicated, you can traverse to parent/children with `q`/`w`, respectively.
You can make a "rough selection" and navigate up to the "container parent",
which is easy to tell because elements are highlighted on the page.

