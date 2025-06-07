---
layout: post
title: How to Surround Text in Vim, Without Plugins
category: posts
---

Surrounding text in Vim/Neovim is _not_ strictly complicated, but finding a
good workflow is not immediately obvious either.

## Recipe

[![demo of text surround in vim](/assets/surround-text-vim/surround.gif)](/assets/surround-text-vim/surround.gif)

- select text (your pick), `c`
- `""`, `ESC`
- `P`

Step by step below.

### Step 1: "changing" text

Select text, and press `c` (change mode).

Alternatively, it's that more convenient, you can use a "[text object](https://vimdoc.sourceforge.net/htmldoc/motion.html#object-select)
selection" like `ciw` to "change" a specific something.

select some text

[![selecting some text, in vim](/assets/surround-text-vim/step1-select.png)](/assets/surround-text-vim/step1-select.png)

press `c` (text is gone)

[![after selecting some text, in vim](/assets/surround-text-vim/step1-change.png)](/assets/surround-text-vim/step1-change.png)

2 birds with 1 scone:
- ready to type, in insert mode
- the deleted text was automatically copied (as a side-effect)

### Step 2: typing wrapper text

Type the wrapping characters yourself. (here: `""`)

[![typing the necessary wrapping characters, in vim](/assets/surround-text-vim/step2-type.png)](/assets/surround-text-vim/step2-type.png)

Go back to normal mode: press `ESC`

### Step 3: pasting

With the cursor directly on the closing character, press `P` (capital p)

[![pasting the original text, in vim](/assets/surround-text-vim/step3-paste.png)](/assets/surround-text-vim/step3-paste.png)

## Comments

I have used [vim-surround](https://github.com/tpope/vim-surround) for a long time. But when
I switched from vim to neovim, I wasn't sure if I _really_ needed to plugin for this.
