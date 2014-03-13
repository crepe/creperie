# Crêperie

Get your batter ready and pour out a beautiful new [Crêpe][crepe] app. When building a simpler API, a single class in your `config.ru` can be sufficient. However, when building a more ambitious API that connects to databases and exposes many endpoints, it's nice to have the sort of file structure that is given to you by a framework like [Rails][rails]. Crêperie gives you the means to generate a structured, ambitious Crêpe API while also providing some convenience on the command line when you're in an existing Crêpe app.

## Installation

```bash
$ gem install creperie
```

## Usage

```
$ crepe --help
Usage:
    crepe [OPTIONS] SUBCOMMAND [ARG] ...

Parameters:
    SUBCOMMAND                    subcommand
    [ARG] ...                     subcommand arguments

Subcommands:
    new                           Generate a new Crêpe application.
    server                        Start the Crêpe server.

Options:
    -v, --version                 Print the Crêperie version and exit.
    -h, --help                    Print this help message and exit.
```

### Creating a new Crêpe application

This will generate a new Crêpe application with a default configuration and environment at a specified path. The provided path will also function as the application's name.

```
$ crepe new --help
Usage:
    crepe new [OPTIONS] APP_PATH

Parameters:
    APP_PATH                      The name and path of your Crêpe application

Options:
    -B, --skip_bundle             Don't run bundle install.
    -G, --skip-git                Don't create a git repository.
    -f, --force                   Overwrite files that already exist.
    -p, --pretend                 Run but do not make any changes
    -q, --quiet                   Suppress status output
    -s, --skip                    Skip files that already exist
    -v, --version                 Print the Crêperie version and exit.
    -h, --help                    Print this help message and exit.
```

### Running the Crêpe server

You can start the Crêpe server from the root directory of your project, or any subdirectory if you wish. This will by default boot a WEBrick server to feed requests to your Crêpe app, but if you bundle `puma`, `thin`, or some other web dispatcher with a Rack handler, that server will be used automatically. Alternatively, you can specify one with the `--server` option.

```
$ crepe server --help
Usage:
    crepe server [OPTIONS]

Options:
    -s, --server SERVER           Serve using the specified dispatcher
    -p, --port PORT               Runs Crêpe on the specified port (default: 9292)
    -o, --host HOST               Binds Crêpe to the specified host (default: "0.0.0.0")
    -E, --env ENV                 Specify the Crêpe environment (default: "development")
    -D, --daemonize               Run Crêpe daemonized in the background
    -P, --pid PIDFILE             Store Crêpe's PID in the specified file
    -c, --config RACKUP_FILE      Specify a Rackup file other than config.ru
    -v, --version                 Print the Crêperie version and exit.
    -h, --help                    Print this help message and exit.
```

### Running the Crêpe console

The Crêpe console will boot an IRB (or Pry, if bundled) session in the context of your application.

```
$ crepe c --help
Usage:
    crepe c [OPTIONS]

Options:
    -E, --env ENV                 Specify the Crêpe environment (default: "development")
    -v, --version                 Print the Crêperie version and exit.
    -h, --help                    Print this help message and exit.
```

## Contributing

1. [Fork it](https://github.com/davidcelis/creperie/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[crepe]: https://github.com/stephencelis/crepe
[rails]: https://github.com/rails/rails
