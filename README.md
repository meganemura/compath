# Compath

Compath generates a guide of directory structure in the project.

## Installation

    $ gem install compath

## Usage

    $ compath --file=.compath.yml

It creates or updates `.compath.yml`.

```yaml
- ".gitignore":
    desc:
- bin/:
    desc:
- bin/console:
    desc:
- bin/setup:
    desc:

...
```

Each object of sequences has a key to object structure.
The key means path, and the object is only able to have `desc` or `scan/` keys.
`desc` is to describe what the path means.
`scan` is to switch scanning files or not for the directory by configuring boolean value (`true`, `false`).

With the following config, `compath` does not scan files of `bin/` directory.

```yaml
- ".gitignore":
    desc:
- bin/:
    desc:
    scan: false

...
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/meganemura/compath.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
