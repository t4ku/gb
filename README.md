gb: gist browser
===================

gb is a gist browers within a terminal for the lazy
who don't want to leave terminal just to remember snippets,
installation notes, command line options etc.

** It's under develpment, and most of description below are not yet
implemented **

Setup
------------

### Installation


### Configuration

Set directory gb uses.

```bash
bundle exec gb init --username=abc --password=def
```

This creates ~/.gb_profile

Usage
-----

### list all my gists(TBD)

```bash
gb list
```
### edit gist(TBD)

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

