# .emacs.d
This is my personal .emacs.d/ directory.  It's based loosely on community best-practices found in the common
"starter packs" that you find but customized to my needs.  Most things are installed via EMACS pkgs from either
ELPA or MELPA (all the pkgs I want are on MELPA if they are on MARMALADE).  I also use the `use-package.el` macro
to make customizing stock packages a little less boilerplate-y.  

# Basic Layout
init.el             - The entry point for emacs customizations, installs/configures pkgs and calls other files
customizations      - Top-Level customizations for basic appearance and behavior
customizations/langs - Programming language mode specific settings for various languages
vendor               - placeholder for non-pkged elisp files.
lib                  - Utility functions / Sugar for things I needed when customizing my env.
