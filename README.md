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

This creates ~/.gb_profile and store auth token there.

Usage
-----

### list all my gists

```bash
gb list
```

### clone gist

```bash
gb clone <gist id>
```

### navigate to local gist repo(TODO)

```bash
gb go <gist id>
```
### search local gist files(TODO)

```bash
gb search <content>
```

Reference
---------

### Gist API

[Gists API](http://developer.github.com/v3/gists/)

