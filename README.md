# [Venture Into Emacs][published url]
## Instructor: [Rem Zolotykh][instructor url]

In this course, you'll learn the necessary skills to begin using Emacs in your day-to-day workflow. We'll learn how to customize it, install and use plugins, and even write your own Lisp functions. Are you ready to venture into Emacs?


## Installation

* clone repo to `~/.dotfiles` folder:

```
cd ~
git clone https://github.com/tutsplus/venture-into-emacs.git .dotfiles
```

* create symbolic links to config files

```
ln -s .dotfiles/emacs .emacs.d
```

* install cask (http://cask.github.io/installation/):

```
curl -fsSkL https://raw.github.com/cask/cask/master/go | python
```

* run cask in `.emacs.d` folder

```
cd ~/.emacs.d
cask
```



These are source files for the Tuts+ course: [Venture Into Emacs][published url]

Available on [Tuts+](https://tutsplus.com). Teaching skills to millions worldwide.

[published url]: https://code.tutsplus.com/courses/venture-into-emacs
[instructor url]: https://tutsplus.com/authors/rem-zolotykh


