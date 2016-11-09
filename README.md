# vim-hindent

Integrates with [hindent](https://github.com/chrisdone/hindent) so every time
you save a Haskell source file it gets automatically prettified.

Simply using `:%!hindent` replaces your whole source file with an error message
from **hindent** when you have a syntax error in your code, this plugin manages
that annoyance.


## Installation

Compatible with `Vundle`, `Pathogen`, `Vim-plug`.


## Configuration

Use the `g:hindent_indent_size` variable to control the number of spaces per
indentation (default = 2).
