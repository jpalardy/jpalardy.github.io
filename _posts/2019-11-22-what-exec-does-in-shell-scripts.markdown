---
layout: post
title: "What Exec Does in Shell Scripts"
category: posts
---

If you think the [answer](http://man7.org/linux/man-pages/man3/exec.3.html) is:

> The exec() family of functions replaces the current process image with a new
> process image.

you are only partially right... That's only true [if you don't redirect](https://www.computerhope.com/unix/bash/exec.htm#examples):

> Redirections are a special case, and exec does not destroy the current shell
> process, but bash will no longer print output to the screen, writing it to
> the file instead.

or from [man bash](https://linux.die.net/man/1/bash) itself (scroll down):

> If command is not specified, any  redirections take  effect  in  the current shell [...]

## Seeing is believing

Put the following in a file called `test.bash`

{% highlight bash %}
echo "before: $$"
exec > stdout.log
echo "after: $$"
{% endhighlight %}

and run it:

{% highlight bash %}
> bash test.bash
before: 78511
> ls
stdout.log  test.bash
> cat stdout.log
after: 78511
{% endhighlight %}

Comments:

- the "after" echo ran (after the exec!)
- echo was redirected to `stdout.log`
- it shows the same process ID (the `$$` variable)

There are [more examples](https://www.computerhope.com/unix/bash/exec.htm#examples) of what's possible:

{% highlight bash %}
# Open myinfile.txt for reading ("<") on file descriptor 3.
exec 3< myinfile.txt
# "-u 3" tells read to get its data from file descriptor 3
read -u 3 mydata
# Close ("&-") the open read descriptor ("<") number 3
exec 3<&-
{% endhighlight %}

## What about the usual exec behavior?

That's still in effect:

{% highlight bash %}
> ls
child.bash  parent.bash
> cat parent.bash
echo "from parent, before: $$"
exec bash child.bash
echo "from parent, after: $$"
> cat child.bash
echo "from child: $$"
> bash parent.bash
from parent, before: 78601
from child: 78601
{% endhighlight %}

Comments:

- parent.bash ran until the exec, then it was replaced by child.bash
- the process ID is the same -- the content of the parent process was replaced by its child process

