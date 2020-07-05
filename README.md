# rubocop-autocorrect

Plugin for vim/neovim. Runs [rubocop](https://rubocop.org/) auto-correction on visually selected lines instead of entire file.

### Installation with vim-plug plugin manager

Add this to plugins section in your .vimrc or init.vim

```
Plug 'etordera/vim-rubocop-autocorrect'
```

### Usage

* Enter visual mode and select lines to auto-correct
* While still in visual mode, press `<leader>b`

### Key mappings

Auto-correction is triggered in visual mode with the `<leader>b` key mapping. You can change this mapping to any other by adding a map in your .vimrc / init.vim to `<Plug>RubocopAutocorrect`. For instance, for triggering auto-correction by pressing `=` in visual mode, add this line to your .vimrc or init.vim:

```
xmap = <Plug>RubocopAutocorrect
```
