---
layout: post
title: "Automatically Show Exit Codes in Bash"
category: posts
---

When software stops running, it produces an [exit code](https://en.wikipedia.org/wiki/Exit_status). In your shell (bash, zsh...),
you can show the exit code using the `$?` variable:

![terminal with exit code](/assets/exit-code-bash/terminal-with-exit-code.png)

{% highlight text %}
# or, usually, as a one-liner...

$ echo something; echo $?
{% endhighlight %}

0 is good, [any other value](https://www.tldp.org/LDP/abs/html/exit-status.html) means something went
wrong. Different values have different meanings, but it's [software specific](https://stackoverflow.com/questions/1101957/are-there-any-standard-exit-status-codes-in-linux).

That works ... but it's awkward. If you need the check the exit code, you need
to remember running it _immediately_ after the command you're interested in.
Otherwise, `$?` will be set to the exit code of whatever you ran after.


## Showing $? Automatically

It doesn't take too much Googling to find solutions to show the exit code after a command exits:

![terminal with loud exit code](/assets/exit-code-bash/terminal-with-loud-exit-code.png)

Here's the code for your `.bashrc`:

{% highlight bash %}
# capture escape sequences for colors...
COLOR_RED=$(tput setaf 1)
ATTR_RESET=$(tput sgr0)

export PROMPT_COMMAND=show_exit_code
show_exit_code() {
  local exit=$?
  if [ "$exit" -ne 0 ]; then
    echo -e "${COLOR_RED}exit: ${exit}${ATTR_RESET}"
  fi
}
{% endhighlight %}

[PROMPT_COMMAND](http://tldp.org/HOWTO/Bash-Prompt-HOWTO/x264.html):

> Bash provides an environment variable called PROMPT_COMMAND.
> The contents of this variable are executed as a regular Bash command just before Bash displays a prompt.

What I like about this solution is that it doesn't mess with `PS1` (unlike
[other](https://gist.github.com/weibeld/f3b6e6187029924a9b3d)
[solutions](https://stackoverflow.com/questions/16715103/bash-prompt-with-last-exit-code))
and it doesn't show anything when the exit code is 0. I've never been a fan of
complicated `PS1` with a lot of fancy colors and statuses.

