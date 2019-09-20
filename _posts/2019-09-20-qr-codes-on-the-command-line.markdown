---
layout: post
title: "QR Codes on the Command-Line"
category: posts
---

## Why QR codes?

<img class="book-cover" src="{{site.url}}/assets/qr-codes/hello-world.png" alt="hello world" />

[QR codes](https://en.wikipedia.org/wiki/QR_code) aren't magical, they boil down to:

- 2d encoding of information  
  _([1000s of characters](https://en.wikipedia.org/wiki/QR_code#Storage) depending on encoding and error correction)_
- machine readability  
  _(especially with the supercomputing cameras in our pockets)_

but, for my own personal uses, it's just one of the fastest way to securely
transfer small amount of data, (_e.g. URLs or passwords_), from my computer to my phone.

To use QR codes, you don't even need networking! It's too bad that [wifi network login](https://en.wikipedia.org/wiki/QR_code#WiFi_network_login)
was never widely adopted, it's one of the most useful use cases for QR out there.

> As of January 2018, iPhones have this feature (wifi network login) built into the camera app under iOS 11.x [...]

Whoah... that wasn't true when I started playing with this!  
I just checked and it works 🤯

## On the command-line

Get the [qrencode](https://fukuchi.org/works/qrencode/index.html.en) package:

{% highlight bash %}
> brew install qrencode     # or use another package manager
{% endhighlight %}

To generate a QR code, dumping it to `stdout` as [ASCII art](https://en.wikipedia.org/wiki/ASCII_art#Unicode):

{% highlight bash %}
> qrencode 'hello world' -t ANSIUTF8 -o -
{% endhighlight %}

![qrencode example]({{site.url}}/assets/qr-codes/qrencode-example.png)

but that's a lot to type; put it in your dotfiles as a function:

{% highlight bash %}
> qr() { qrencode "$1" -t ANSIUTF8 -o -; }
# call as: qr 'hello world'
{% endhighlight %}

There's a bunch of output formats: PNG, PNG32, EPS, SVG, XPM, ANSI, ANSI256,
ASCII, ASCIIi, UTF8, ANSIUTF8. Feel free to experiment 😃

## On the phone

I'm on iOS and I've been using [Barcode](https://apps.apple.com/us/app/barcode/id522354642). It gives you a contextual menu when it finds a QR code:

- text: copy to clipboard, share
- URL: copy to clipboard, share, open in safari/chrome

I hadn't realized that QR codes can be read directly in the iOS camera app...
thank you Apple! It's a bit finicky (try it, you'll see what I mean) but it works.

