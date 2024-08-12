---
layout: post
title: Using Shell Functions Casually
category: posts
date: 2024-08-11 23:41 -0500
---
Most people know they can add functions to the shell, but often limit
themselves to their dotfiles.

Nothing stops you from adding functions to your running session.

## Functions in interactive shells

If you're already in a shell, you can define a function in exactly the same way
you would in a startup script, by typing it at the prompt:

```bash
# this is bash
> ll() {
  ls -l
}
> ll
# runs `ls -l`
```

```bash
# this is fish
> function ll
  ls -l
end
> ll
# runs `ls -l`
```

## Why would you do that?

Usually, I use this to handle positional arguments more easily

```bash
# this is bash
> g() {
  grep -ril "$@" .
}
> g "something"
# grep -ril "something" .
```

`grep` invocations look like `grep $WHAT $WHERE`. Here I'm hardcoding `$WHERE` (`.`) and making `$WHAT` the last argument. While I'm at it, I'm also adding some flags (`-ril`).

```bash
> g "this"
# ...
> g "that"
# ...
> g "the other thing"
# ...
```

Not having to navigate-and-edit to the second-to-last position every time makes using the command-line _delightful_.

(although for this _very specific_ case, a better solution would be [ripgrep](https://github.com/BurntSushi/ripgrep) 😄)

## When to use this?

If you keep running variations of the same command.

If you keep editing previous commands.

If you have a "one-shot" batch job with _a-lot-of-typing_ but not worth a script.

## Tips and Tricks

Remember that your function will disappear when you exit the shell. Consider this a feature rather than a bug: your
temporary function garbage collecting itself 🚀

Since this function is going away, don't feel like you need to give it a great name; the easier to type the better.

Reference: how to define functions and handle arguments

- [Passing parameters to a Bash function](https://stackoverflow.com/questions/6212219/passing-parameters-to-a-bash-function) - arguments as `$1`, `$2` ...
- [Fish : create a function](https://fishshell.com/docs/current/cmds/function.html) - arguments in `$argv` array

Pro tip: for a better command-line experience, you can edit your command-line in `$EDITOR` (which is a killer feature, if you didn't know...)

- [Bash: Edit command in your editor and execute directly](https://dev.to/chhajedji/bash-edit-command-in-your-editor-and-execute-directly-30ef)
- [How to edit command line in full screen editor in ZSH?](https://unix.stackexchange.com/questions/6620/how-to-edit-command-line-in-full-screen-editor-in-zsh)
- [Fish : Command-line editor](https://fishshell.com/docs/current/interactive.html#command-line-editor)


