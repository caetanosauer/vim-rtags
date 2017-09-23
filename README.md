vim-rtags
=========
C++ code navigation in Vim editor.

rtags uses clang to find symbol references, definitions, etc.


Setup
-----
[vim-plug](https://github.com/junegunn/vim-plug):
```vim
Plug 'yakubin/vim-rtags'
```

[pathogen.vim](https://github.com/tpope/vim-pathogen):
```sh
cd ~/.vim/bundle && \
git clone https://github.com/yakubin/vim-rtags
```

[Vundle](https://github.com/VundleVim/Vundle.vim):
```vim
Plugin 'yakubin/vim-rtags'
```

The rtags bin directory needs to be in your PATH.


Usage
-----
<table>
<tr>
<td>:RtagsFollowSymbolUnderCursor</td>
<td>find definition/declarations of the symbol under the cursor</td>
</tr>
<tr>
<td>:RtagsFindRefsToSymbolUnderCursor</td>
<td>find references to the symbol under the cursor</td>
</tr>
<tr>
<td>:RtagsGetTypeOfSymbolUnderCursor</td>
<td>print the type of symbol under the cursor in the status line</td>
</tr>
<tr>
<td>:RtagsFind <em>symbol</em></td>
<td>find definition/declarations of <em>symbol</em></td>
</tr>
<tr>
<td>:RtagsRegexFind <em>pattern</em></td>
<td>find definitions/declarations of symbols matching <em>pattern</em></td>
</tr>
</table>

Suggested keymaps
-----
```vim
nnoremap <silent> <F1> :RtagsFollowSymbolUnderCursor<CR>
nnoremap <silent> <F2> :RtagsFindRefsToSymbolUnderCursor<CR>
nnoremap <silent> t :RtagsGetTypeOfSymbolUnderCursor<CR>
```

The [Vim-unimpared](https://github.com/tpope/vim-unimpaired) plugin can help with navigating the output of vim-rtags. It maps:
* `[l, ]l` to move up/down a line in the "location list" window
* `[L, ]L` to move to first/last entry, and
* `[<C-L>, ]<C-L>` to jump to previous/next file.


To do
-----
* Make it work when a source file has not been saved. Note: buffers other than the current one may have significant unsaved changes. (A special case exists where a buffer has never been saved.) The simplest solution might be just to save everything that has been modified/created before calling rtags.
* Automatically start rdm. (rc should start rdm if it can't connect to rdm.)
* Lots more!
