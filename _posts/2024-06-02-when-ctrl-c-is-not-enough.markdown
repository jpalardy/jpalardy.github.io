---
layout: post
title: When ctrl-c Is Not Enough
category: posts
---
## Situation

If you've been stuck in a terminal where `ctrl-c` didn't seem to work

```text
> bash sig-catcher
loop 1
loop 2
loop 3
^C
loop 4
loop 5
^C^C^C^C
loop 6
loop 7
loop 8
# it keeps going ...
```

you know how frustrating it can be. 🤬

## Try ctrl-\

Think of `ctrl-\` [^1] as a "harder" `ctrl-c`

```text
> bash sig-catcher
loop 1
loop 2
loop 3
^\sig-catcher: line 5: 38922 Done
```

It doesn't always work, but it's worth trying.

## Details

Here's the script that I used above, to experiment with:

{% highlight bash %}
trap '' INT TERM EXIT

seq 1 1000 | while read -r i; do
  echo "loop $i"
  sleep 1
done
{% endhighlight %}

What you need to know:

- empty trap -- `trap ''` -- will ignore the listed signals: `INT TERM EXIT`
- `ctrl-c` generates a `INT`, now caught and ignored by `TRAP`

In `man kill`, there's a useful list:

```text
Some of the more commonly used signals:

1       HUP (hang up)
2       INT (interrupt)
3       QUIT (quit)
6       ABRT (abort)
9       KILL (non-catchable, non-ignorable kill)
14      ALRM (alarm clock)
15      TERM (software termination signal)
```

For context:
- a regular `kill` command sends a: `15 / TERM`:
- a `kill -9` command sends a: `9 / KILL`
- `ctrl-c` sends a: `2 / INT`
- `ctrl-\` sends a: `3 / QUIT`

And how do we know how `ctrl-c` and `ctrl-\` are hooked up?

```text
> stty -e                                                                                                                           ~
speed 38400 baud; 40 rows; 140 columns;
lflags: icanon isig iexten echo echoe echok echoke -echonl echoctl
        -echoprt -altwerase -noflsh -tostop -flusho pendin -nokerninfo
        -extproc
iflags: -istrip icrnl -inlcr -igncr -ixon -ixoff ixany imaxbel iutf8
        -ignbrk brkint -inpck -ignpar -parmrk
oflags: opost onlcr -oxtabs -onocr -onlret
cflags: cread cs8 -parenb -parodd hupcl -clocal -cstopb -crtscts -dsrflow
        -dtrflow -mdmbuf
discard dsusp   eof     eol     eol2    erase   intr    kill    lnext
^O      ^Y      ^D      <undef> <undef> ^?      ^C      ^U      ^V
min     quit    reprint start   status  stop    susp    time    werase
1       ^\      ^R      ^Q      ^T      ^S      ^Z      0       ^W
```

Find `intr` and `quit` with their `ctrl` (`^`) bindings

## No kill -9 binding?

I thought there might be harder and harder kill bindings, but apparently not.

If you need `kill -9`, you _could_ bind it but there are no defaults.

-------------------------------------------------

[^1]: `ctrl-backslash`

