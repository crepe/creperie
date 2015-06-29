# Creperie [![Build Status](https://travis-ci.org/crepe/creperie.svg?branch=master)](https://travis-ci.org/crepe/creperie)

Get your batter ready and pour out a beautiful new [Crepe][crepe] app. When building a simpler API, a single class in your `config.ru` can be sufficient. However, when building a more ambitious API that connects to databases and exposes many endpoints, it's nice to have the sort of file structure that is given to you by a framework like [Rails][rails]. Creperie gives you the means to generate a structured, ambitious Crepe API while also providing some convenience on the command line when you're in an existing Crepe app.

## Installation

```bash
$ gem install creperie --pre
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
    new                           Generate a new Crepe application.
    console, c                    Start the Crepe console.
    server, s                     Start the Crepe server.

Options:
    -v, --version                 Print the Creperie version and exit.
    -h, --help                    Print this help message and exit.
```

### Creating a new Crepe application

This will generate a new Crepe application with a default configuration and environment at a specified path. The provided path will also function as the application's name.

```
$ crepe new --help
Usage:
    crepe new [OPTIONS] APP_PATH

Parameters:
    APP_PATH                      The name and path of your Crepe application

Options:
    -B, --skip_bundle             Don't run bundle install.
    -G, --skip-git                Don't create a git repository.
    -f, --force                   Overwrite files that already exist.
    -p, --pretend                 Run but do not make any changes
    -q, --quiet                   Suppress status output
    -s, --skip                    Skip files that already exist
    -v, --version                 Print the Creperie version and exit.
    -h, --help                    Print this help message and exit.
```

### Running the Crepe server

You can start the Crepe server from the root directory of your project, or any subdirectory if you wish. This will by default boot a WEBrick server to feed requests to your Crepe app, but if you bundle `puma`, `thin`, or some other web dispatcher with a Rack handler, that server will be used automatically. Alternatively, you can specify one with the `--server` option.

```
$ crepe server --help
Usage:
    crepe s [OPTIONS]

Options:
    -s, --server SERVER           Serve using the specified dispatcher
    -o, --host HOST               Binds Crepe to the specified host (default: "0.0.0.0")
    -p, --port PORT               Runs Crepe on the specified port (default: 9292)
    -E, --env ENV                 Specify the Crepe environment (default: "development")
    -P, --pid PIDFILE             Store Crepe's PID in the specified file
    -c, --config RACKUP_FILE      Specify a Rackup file other than config.ru
    -I, --include PATH            Add paths (colon-separated) to Crepe's $LOAD_PATH
    -r, --require LIBRARY         Require a library before Crepe runs
    -d, --debug                   Turn on debug output ($DEBUG = true)
    -w, --warn                    Turn on warnings ($-w = true)
    -D, --daemonize               Run Crepe daemonized in the background
    -v, --version                 Print the Creperie version and exit.
    -h, --help                    Print this help message and exit.

```

### Running the Crepe console

The Crepe console will boot an IRB (or Pry, if bundled) session in the context of your application.

```
$ crepe console --help
Usage:
    crepe console [OPTIONS]

Options:
    -E, --env ENV                 Specify the Crepe environment (default: "development")
    -v, --version                 Print the Creperie version and exit.
    -h, --help                    Print this help message and exit.
```

## Contributing

1. [Fork it](https://github.com/crepe/creperie/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[crepe]: https://github.com/crepe/crepe
[rails]: https://github.com/rails/rails
