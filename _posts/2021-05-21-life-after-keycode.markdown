---
layout: post
title: Life After KeyCode
category: posts
---
Over the years, I wrote a bunch of quick JavaScript apps with code similar to:

{% highlight javascript %}
document.addEventListener("keydown", ev => {
  // ESC
  if (ev.keyCode === 27) {
     // ...
  }
  // Enter
  if (ev.keyCode === 13) {
     // ...
  }
  // ...
{% endhighlight %}

but I found out recently that [keyCode is deprecated](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyCode):

![deprecation warning from MDN](/assets/keycode/keycode-deprecated.png)

## What now?

There are better options! Let's have a quick look at available [KeyboardEvent](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent) properties:

{% highlight javascript %}
document.addEventListener("keydown", (ev) => {
  console.log({
    code: ev.code,
    key: ev.key,
    keyCode: ev.keyCode,
    which: ev.which,
  });
});
{% endhighlight %}

and try pressing:

- esc
- right square bracket
- space
- "arrow right"
- lowercase n
- uppercase n

![screenshot of keydown properties](/assets/keycode/event-log.png)

## Observations: keyCode and which

Both [keyCode](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyCode)
and [which](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/which)
are deprecated.

Also, I can't see a difference in values (using Chrome 90), but it seems like it might
[differ](https://stackoverflow.com/questions/4471582/keycode-vs-which/4471635)
[between](https://thisthat.dev/key-vs-key-code-vs-which/)
[browsers](https://stackoverflow.com/questions/19249351/what-is-the-difference-between-e-keycode-and-e-which)...
And having worked with them before, and their numeric outputs, I would say that's good riddance.

## Observations: code

The other difference that stood out was the handling of `shift`. Both
upper/lower `n` registered as `KeyN` for the [code](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/code)
property. That would put the responsibility of checking the [shiftKey](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/shiftKey)
property ourselves, to differentiate the events. 😩

That's a bit more surprising for keys we don't typically associate as "being the same":

![bracket, but not curly bracket...](/assets/keycode/bracketRight.png)

Are `]` and `}` both "BracketRight", with only a difference in `shift`? 🤔  
That doesn't sound right to me...

(is `#` a shifted `Digit3`? ... on all keyboards, all the time?)

## Observations: key

Finally, the [key](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key) property seems to be the way to go.

- it generates what I would expect (usually)
- including handling `shift`
- isn't numeric (which reeked of magic numbers)

The downside would be differentiating a `left/right` with `shift/ctrl/alt/meta` -- a case that I don't usually handle. (though something to keep in mind)

If you're wondering exactly what you're going to get when pressing a key, check out the KeyboardEvent [Key Values](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key/Key_Values) page.

## Sidenote: shift/ctrl/alt/meta

[KeyboardEvent](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent) has boolean properties for "control keys":

- [altKey](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/altKey)
- [ctrlKey](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/ctrlKey)
- [metaKey](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/metaKey) -- aka: "windows", "command" keys
- [shiftKey](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/shiftKey)

which I haven't historically been great at keeping track of... It's easy to trigger on the `a` key, but to forget to check the `metaKey` status and prevent `cmd-a` from triggering normally. (usually due to an eager [preventDefault](https://developer.mozilla.org/en-US/docs/Web/API/Event/preventDefault)). Which leads me to...

## Quick tip: key-combinations

Since I stumbled on the `keyCode` deprecation, I've been refactoring my apps. I've been happy with this snippet of code:

{% highlight javascript %}
document.addEventListener("keydown", ev => {
  const keys = [
    ev.metaKey && "Meta",
    ev.ctrlKey && "Ctrl",
    ev.altKey && "Alt",
    ev.key,
  ].filter((v) => v).join("-");
  if (keys === "a") {
     // ...
  }
  if (keys === "Meta-a") {
     // ...
  }
});
{% endhighlight %}

which keeps these boolean cases more explicit and, thankfully, mutually exclusive.

Some things to consider:

- the code depends on the behavior of `shift` discussed above -- so it's already "handled"
- `altKey` is "problematic" on the Mac ... it might unlock alternative symbols, for example `Alt-z` becomes `Alt-Ω` ... a kind of "feature".
- there are cases where I would consider `Meta-a` and `Ctrl-a` to be the same; what a Windows user vs a Mac user would expect to type. It would be relatively easy to handle this.

