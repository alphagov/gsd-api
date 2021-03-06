# Service Performance

This is the application for interacting with Service Performance data. It contains:

- the application frontend for viewing metrics
- the publishing workflow for collecting metrics from Services
- an admin interface to coordinate data collection

## Setup

Use the `recursive` flag when cloning this repository. This will include the necessary sub-modules:

```
git clone --recursive git@github.com:alphagov/service-performance.git
```

You must install the version of Ruby defined in [`.ruby-version`](https://github.com/alphagov/service-performance/blob/master/.ruby-version).

You can easily switch between Ruby versions with [rbenv](http://rbenv.org/), which you can install using [`Homebrew`](https://brew.sh/):

```
brew install rbenv
```

For example, if you have installed rbenv, you can run:

```
rbenv install 2.4.2
```

You will also need [Bundler](http://bundler.io/) in order to install all the application's dependencies.

```
gem install bundler
```

You should note that each time you install Bundler, you will have it available for your current version of Ruby. If you ever switch Ruby versions, you will need to reinstall Bundler.

Bundling the gems will fail unless Qt is installed.

The `capybara-webkit` gem needs Qt version 5.5. To install qt:

```
brew install qt@5.5
export PATH="/usr/local/opt/qt@5.5/bin:$PATH"
```

After installing Bundler and Qt, you can install the dependencies for the application with:

```
bundle install
```

You then need to configure the database you will be using.

The database setup instructions can be found [here](https://docs.google.com/document/d/11eHHI9FzHS9dxWc7LToxYUUvB4QYO5ASRVebaBkDd6U/edit?usp=sharing).


To start the server, use the conventional `rails s` command.

If you are already running another app on port 3000, then pass in a new port number with `rails s --port <NEW NUMBER>`

You can test the server is running by visiting [http://127.0.0.1:3000/](http://127.0.0.1:3000/) in a web browser.


## Deployment

### Staging

Deployments are initiated by merging `master` into `staging`, and then by pushing the `staging` branch.

### Production

Production deployments are not yet configured.

## Tests

To run tests, you should run

```
bin/rails spec
```

To run an individual test:

```
bundle exec rspec spec/path/to/file
```

## Linter

```
bundle exec govuk-lint-ruby app lib spec
```

### Frontend test setup

Make sure you have [npm](https://www.npmjs.com/get-npm) installed, as well as a recent version of [Node.js](https://nodejs.org/en/).

You can install and manage different versions of Node.js using [nvm](https://github.com/creationix/nvm#installation).

To install a version of Node.js using nvm, you should only need to run a single command. For example, for version 6.11.0:

```
nvm install 6.11.0
```

There is [an `.nvmrc` file](https://github.com/creationix/nvm#nvmrc) in the root directory of this repository that nvm will recognise when you call certain commands (such as `nvm use`) without arguments.

To install the frontend dependencies, run:

```
npm install
```

### Frontend tests

#### Linting

[GDS](https://github.com/alphagov/styleguides/blob/master/js.md#linting) uses [Standard JS](https://standardjs.com/) for linting:

```
npm run lint
```

This command will lint the JavaScript files it finds in the `app/assets/javascripts/*` directory. It will return npm error traces and plain-English error messages.

#### Unit tests

GDS uses [Jest](https://facebook.github.io/jest/) for JavaScript unit tests:

```
./script/run-npm-test
```

This command will run any JavaScript test files it finds across the whole codebase.
