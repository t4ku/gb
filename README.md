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

```bash
bundle exec gb init --username=abc --password=def
```

It creates ~/.gb_profile and store auth token there.

Usage
-----

### list all my gists

```bash
gb list
```

TODO
----

* [=] caches response in local dir for later reuse
  * [=] optionaly, fetch from api(sync dir)
* commands
  * fetch(sync)
    * gist
    * all my gists
  * edit
    * pass local gist path, launch editor

Reference
---------

### Gist API

[Gists API](http://developer.github.com/v3/gists/)

