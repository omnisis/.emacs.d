# .emacs.d
This is my personal .emacs.d/ directory.  It's based loosely on community best-practices found in the common
"starter packs" that you find but customized to my needs.  Most things are installed via EMACS pkgs from either
ELPA or MELPA (all the pkgs I want are on MELPA if they are on MARMALADE).  I also use the ```use-package.el``` macro
to make customizing stock packages a little less boilerplate-y.  

# Directory Layout
  * lib :: Utility functions, non-config code
  * general :: Top-Level thematic customizations for basic appearance and behavior
  * langs ::  Programming language mode-specific settings for various languages
  * modes :: Major/Minor (non programming) mode-specific settings
  * vendor :: Non-pkged lisp files
  * hacks :: ELISPs that your mother warned you about
