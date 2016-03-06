# initialize [![Gem version](http://img.shields.io/gem/v/initialize.svg?style=flat-square)](http://rubygems.org/gems/initialize)

Ruby gem to completely customize the execution order of Rails config initializers.

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'initialize'
```

And then execute:

```bash
$ bundle install
```

## Usage

For example, say you have the following Rails application:

```
├── app
├── bin
├── config
│   ├── environments
│   ├── initializers
│   │   ├── assets.rb
│   │   ├── backtrace_silencers.rb
│   │   ├── configure_rollbar.rb
│   │   ├── filter_parameter_logging.rb
│   │   ├── inflections.rb
│   │   ├── init_hub_settings.rb
│   │   ├── load_extensions.rb
│   │   ├── mime_types.rb
│   │   ├── schedule_app_launches.rb
│   │   ├── schedule_app_upgrades.rb
│   │   ├── schedule_hub_upgrades.rb
│   │   ├── schedule_ngrok.rb
│   │   ├── schedule_task_executions.rb
│   │   ├── session_store.rb
│   │   └── wrap_parameters.rb
│   ├── application.rb
│   ├── boot.rb
│   ├── database.yml
│   ├── environment.rb
│   ├── routes.rb
│   └── secrets.yml
├── db
├── lib
├── public
├── Gemfile
├── Gemfile.lock
├── Rakefile
└── README.md
```

By default, Rails will run the files in `config/initializers` in alphabetical (filename) order, which isn't always what you want. To get around this, [the Rails team suggests prefixing initializer filenames with a numeric value](http://guides.rubyonrails.org/configuring.html#using-initializer-files), but such a solution is not the most elegant in my opinion.

With this gem, elegant control is back in your hands; you can define an `initializers` array in `config/application.rb` like so:

```ruby
class Application < Rails::Application
  config.initializers = [
    "assets",
    "backtrace_silencers",
    "filter_parameter_logging",
    "inflections",
    "mime_types",
    "session_store",
    "wrap_parameters",
    "load_extensions",
    "init_hub_settings",
    "configure_rollbar",
    "schedule_ngrok",
    "schedule_hub_upgrades",
    "schedule_app_upgrades",
    "schedule_app_launches",
    "schedule_task_executions"
  ]
end
```

Notice how the ordering of initializers is not alphabetical? When the application starts, initializers will run in the order that they appear in the array!

Additionally, this opens up interesting possibilities for your Rails application, like (for example) enabling/disabling specific initializers based on some condition determined at runtime.
