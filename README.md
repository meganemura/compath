# Compath

Compath generates a guide of directory structure in the project.

## Installation

    $ gem install compath

## Usage

    $ compath

It creates or updates `.compath.yml`.

```yaml
---
bin/:
exe/:
lib/**/*:
spec/:

...
```

The top level object of yaml is mapping. Each key of objects means path, and each value of objects means description.
Additional convention of configuration is that the path (key) which is end with `**/*` or `*` tells Compath to stop scanning of children of the directory.

Initial generated config has keys of only top level paths.
With the following changes of `.compath.yml`, `compath` will also scan files of `lib/` directory.

```yaml
---
bin/:
exe/:
lib/:   # Removed `**/*`
spec/:

...
```

It will be updated to the following content by compath.

```yaml
---
bin/:
exe/:
lib/:
lib/compath/:
spec/:

...
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/meganemura/compath.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
