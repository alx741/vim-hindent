# vim-hindent

Integrates with [hindent](https://github.com/chrisdone/hindent) so every time
you save a Haskell source file it gets automatically prettified.

Simply using `:%!hindent` replaces your whole source file with an error message
from **hindent** when you happen to have a syntax error in your code, this
plugin manages that annoyance.

*Note:* If you prefer *stylish-haskell* use
[vim-stylishask](https://github.com/alx741/vim-stylishask) instead.

## Installation

Compatible with `Vundle`, `Pathogen`, `Vim-plug`.


## Usage

By default, *vim-hindent* will format your code automatically when saving a
Haskell source file, but you can use the `:Hindent` command at any time to
format the current file.

Use `:HindentEnable`, `:HindentDisable`, `:HindentToggle` to enable, disable, or
toggle running `hindent` on save.


## Configuration

Trigger *hindent* when saving (default = 1):

```vim
g:hindent_on_save = 1
```

Number of spaces per indentation (default = '', uses `hindent` default of 2):

```vim
g:hindent_indent_size = 2
```

Max line length (default = `''`, uses `hindent` default of 80):

```vim
g:hindent_line_length = 100
```
