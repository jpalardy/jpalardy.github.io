---
layout: post
title: How to Write Self-Contained AWK Scripts
category: posts
---

## A Quick Why

I won't try to sell AWK in this post, [I've done it before.](/posts/why-learn-awk/)

Over time, I've migrated most of my [utility scripts](https://github.com/jpalardy/dotfiles/tree/main/bin)
to AWK; it's my default choice when I write new scripts.

The "classic" way, though simple, forces you to live inside a bash string. We can do better.

## The "Classic" Way

Let's write a simple script, to show line-length along with content.

> This isn't about AWK programming; the focus is on packaging your script. Also, most scripts would be longer and multi-line.

Create a new file, call it `len` (for example), and paste this

```bash
#!/bin/bash

awk '{print length, $0}' "$@"
```

Make it executable with `chmod +x len`. Run it on a file, on the script itself for example:

```bash
# run it on a file
> ./len len
# 11 #!/bin/bash
# 0
# 29 awk '{print length, $0}' "$@"

# or run it as a filter
> cat len | ./len
# 11 #!/bin/bash
# 0
# 29 awk '{print length, $0}' "$@"

# find the largest line, a common use-case
> ./len len | sort -nr | head -n1
# 29 awk '{print length, $0}' "$@"
```

Pros

- simple or, at least, familiar
- could be combined with other command-line tools (e.g. `sort -n` ...)

Cons

- bash process wrapper
- all AWK logic crammed in single quotes...

## A Simpler Way

Edit the `len` script down to this

```awk
#!/usr/bin/env -S awk -f

{print length, $0}
```

It works the same as the bash-wrapper version

```bash
# run it on a file
> ./len len
# 24 #!/usr/bin/env -S awk -f
# 0
# 18 {print length, $0}

# or run it as a filter
> cat len | ./len
# 24 #!/usr/bin/env -S awk -f
# 0
# 18 {print length, $0}
```

Pros

- slightly simpler
- native-AWK execution, without process wrapper
- native-AWK syntax highlighting in your editor

The only real sticking point is the `env` line...

## A Full env shebang

Why is the shebang line so complicated?

You can't run `#!/usr/bin/env awk` because you need the `-f` flag.

You can't run `#!/usr/bin/env awk -f` because some versions of `env` only take one argument.

You need `#!/usr/bin/env -S awk -f` to work around most of these problems.

But now that I've given it to you, you're all set. (and this might come in useful in other circumstances)

## A Longer Example

If you're going to write longer scripts, the "native-AWK syntax highlighting" is the major benefit.

For example, [this script](https://github.com/jpalardy/dotfiles/blob/main/bin/vim-helpers/roma) that converts hiragana to romaji
runs at around 150 lines.

[![example of a larger AWK script](/assets/self-contained-awk/roma.jpg)](/assets/self-contained-awk/roma.jpg)
