# Crêperie

Pour yourself a new [Crêpe][crepe] app. This is a work in progress.

## Installation

```bash
$ gem install creperie
```

## Usage

### Creating an application

```bash
$ crepe new --help
Usage:
  crepe new APP_NAME

Options:
  -B, [--skip-bundle]  # Don't run bundle install
  -G, [--skip-git]     # Don't create a git repository
  -h, [--help]         # Print this usage information and exit

Runtime options:
  -f, [--force]    # Overwrite files that already exist
  -p, [--pretend]  # Run but do not make any changes
  -q, [--quiet]    # Suppress status output
  -s, [--skip]     # Skip files that already exist

Create a new Crepe application
```

## Contributing

1. [Fork it](https://github.com/davidcelis/creperie/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[crepe]: https://github.com/stephencelis/crepe
