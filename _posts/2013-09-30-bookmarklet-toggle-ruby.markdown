---
layout: post
title: "Bookmarklet: Toggle Ruby"
category: posts
---

Ruby characters are characters placed on top of Chinese characters to show
pronunciation. Wikipedia can explain [ruby characters][rubyCharacters] better than I can.

In practice, it looks like this: <ruby>日本語<rt>にほんご</rt></ruby>は<ruby>難<rt>むずか</rt></ruby>しいです. The Japanese characters above the text are called [furigana](http://en.wikipedia.org/wiki/Furigana).

What's interesting is what the HTML markup looks like:

![HTML ruby markup](/assets/toggleruby/markup.png)

The `ruby` tag contains a `rt` (ruby text) with the pronunciation. The browser
has some flexibility over the rendering, but the ruby usually goes on top, in a
smaller font.

I created a bookmarlet to toggle the ruby text's visibility: <a href="javascript:(function()%7Bvar%20id%3D%22c8f38bbf013e6f254dfe129984188c9a2646b793%22%2Cd%3Ddocument%2Cstyle%3Dd.getElementById(id)%3Bstyle%3Fd.head.removeChild(style)%3A(style%3Dd.createElement(%22style%22)%2Cstyle.innerHTML%3D%22rt%20%7B%20visibility%3A%20hidden%3B%20%7D%22%2Cstyle.id%3Did%2Cd.head.appendChild(style))%3B%7D)()">toggle ruby</a>. Click it now and watch the ruby in the 2nd paragraph disappear/appear on each click. Drag the link to your bookmark toolbar to install.

Toggling the ruby looks like this on a news site:

![HTML ruby markup](/assets/toggleruby/toggleRuby.gif)

Why is this useful? If you're practicing your kanji reading, ruby text is the
answer. You might want to hide it — until you try to read it for yourself. Then,
you can show it again to check your answer.

The code for this ([toggleRuby.js](https://github.com/jpalardy/bookmarklets/blob/main/src/toggleRuby.js))
is in my [bookmarklets](https://github.com/jpalardy/bookmarklets) repository on github.

[rubyCharacters]: http://en.wikipedia.org/wiki/Ruby_character

