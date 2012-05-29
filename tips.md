
### Gem

#### gemspec

create gem skelton

[New Gem with
Bundler](http://railscasts.com/episodes/245-new-gem-with-bundler)

```
bundle gem gb
```

gb.gemspec
```
  gem.add_dependency('json')
  gem.add_development_dependency('rspec')
```

if the gem needs other gem only in development, use "add_dependency".

### Rspec

[Guard-rspec](https://github.com/guard/guard-rspec) is great.

```bash
gem 'guard'
gem 'guard-rspec'

# install gem
bundle install

# create Guardfile
guard init rspec

# start watching
guard
```

[FakeFS](https://github.com/defunkt/fakefs) is a unit test library
that fake local filesystem.

### Cucumber

* [Cucumber Wiki](https://github.com/cucumber/cucumber/wiki)
  * [Hooks](https://github.com/cucumber/cucumber/wiki/Hooks)
  * [Background](https://github.com/cucumber/cucumber/wiki/Background)


### Gist API response 

Auth response

```
.{"scopes":["gist"],"updated_at":"2012-05-27T06:02:51Z","app":{"url":"http://developer.github.com/v3/oauth/#oauth-authorizations-api","name":"gist
browser in terminal
(API)"},"url":"https://api.github.com/authorizations/380294","token":"be02ae3ad536c36fbfa4b11f6035d14ea48cfc9b","note":"gist
browser in
terminal","note_url":null,"created_at":"2012-05-27T06:02:51Z","id":380294}
```

 unset SSH_ASKPASS
