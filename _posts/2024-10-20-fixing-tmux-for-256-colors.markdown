---
layout: post
title: Fixing tmux for 256 colors
category: posts
---
## Background

Recently, I've been experimenting with
[WezTerm](https://wezfurlong.org/wezterm/index.html) and
[Neovim](https://neovim.io/). And I've also been trying
[various](https://github.com/sainnhe/gruvbox-material)
[colorschemes](https://github.com/folke/tokyonight.nvim). [^1] Things didn't
look right, but since I had been changing so many things at the same time, it
was hard to pinpoint the cause.

It's subtle, but it's there. Neovim running outside tmux:
- blue-ish "tokyonight" theme
- popup in (slightly) different color (black)

[![nvim running outside tmux](/assets/tmux-256/outside-tmux.png)](/assets/tmux-256/outside-tmux.png)

Neovim running **inside** tmux:
- darker, black-ish, background
- popup in _SAME_ background color, making it hard to distinguish
- generally, more "muddy" colors

[![nvim running inside tmux](/assets/tmux-256/inside-tmux.png)](/assets/tmux-256/inside-tmux.png)

(_This is an example of what makes it hard for people to switch their core tools. After spending so much time
in (classic) Vim, I've managed to track down all these nits ..._)

## Tracking it down

Thanks to [Setting up True Color Support for Neovim and Tmux on Mac](https://jdhao.github.io/2018/10/19/tmux_nvim_true_color/), try and give this
AWK script a go (in bash or zsh)

```
awk 'BEGIN {
  s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
  for (colnum = 0; colnum<77; colnum++) {
    r = 255-(colnum*255/76);
    g = (colnum*510/76);
    b = (colnum*255/76);
    if (g>255) g = 510-g;
    printf "\033[48;2;%d;%d;%dm", r,g,b;
    printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
    printf "%s\033[0m", substr(s,colnum+1,1);
  }
  printf "\n";
}'
```

If _everything_ is configured properly, it looks like the first one

[![a comparison between a uniform and jagged band of colors](/assets/tmux-256/good-and-bad.png)](/assets/tmux-256/good-and-bad.png)

if _NOT_, it's closer to the second one. (in tmux, misconfigured)

## Recommendations

Ensure your TERM variable, outside tmux, says `xterm-256color`

```shell
> echo $TERM
xterm-256color

# in practice, in your shell startup script
export TERM="xterm-256color"
# or fish equivalent ...
```

but the details depend on what terminal you're running. The last piece is to put

```shell
set -a terminal-features 'xterm-256color:RGB'
```

in your `tmux.conf` file. You will have to restart tmux for this change to take effect.

## Trust Neovim

One thing that put me on the right track was running `:checkhealth` in Neovim  
(line 42)

[![neovim's checkhealth gives a tmux recommendation](/assets/tmux-256/neovim-warning.png)](/assets/tmux-256/neovim-warning.png)

You might want to check your output (_EVEN_ if you don't intend to running Neovim) and see what
other tidbits are in there.

Once I saw that, I knew exactly what to look for in Google and StackOverflow.

---

[^1]: interesting stories in themselves ... for another day
