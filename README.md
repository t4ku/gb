gb: gist browser
===================

gb is a gist browers within a terminal for the lazy
who don't want to leave terminal just to remember snippets,
installation notes, command line options etc.

Setup
------------

### Installation

```bash
gem install gb
```
### Configuration

Set directory gb uses.

```bash
gb config --path=/home/t4ku/gb/
```

Usage
-----

### list all my gists

```bash
gb list
```
### edit gist

```bash
gb edit <gist ID>
```

TODO
----

### Senario

* list all gists I posted, select the file, edit it, and commit the
  change.
* Instantly create a gist.
* filter gists by title, language, gist type(filetype maybe).

Reference
---------

### Gist API

[Gists API](http://developer.github.com/v3/gists/)

