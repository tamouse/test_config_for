# test_config_for

An example rails application build for learning what the `config_for`
method does during Rails configuration.

See
<http://api.rubyonrails.org/classes/Rails/Application.html#method-i-config_for>
for the documentation on the `config_for` method.

The following is also a blog post at
<http://blog.tamouse.org/swaac/2015/01/20/rails-4-dot-2-config-for/>.

There have been a lot of blog posts and articles written on how to add
application-specific configurations to a Rails app. In version 4.2,
there is a method called `config_for` which makes a lot of that
obsolete, simplifying the results.

[`config_for`](http://api.rubyonrails.org/classes/Rails/Application.html#method-i-config_for)
is a method on `Rails.application`. It can be called bar within all
the normal configuration contexts, such as inside
`config/environments/development.rb` and such.

What it does is fairly straightforward, reading a YAML+ERB file from
the `config` directory, returning the appropriate section based on the
current Rails environment.

It's a simple enough implementation:
<https://github.com/rails/rails/blob/1d1239d32856b32b19c04edd17d0dd0d47611586/railties/lib/rails/application.rb#L226>
(Note of course this is a volatile link). It's implemented in
Rails::Application#config_for.

You pass in a symbol that corresponds to a file name under `config`,
so `config_for(:app_config)` loads up the appropriate environment
variables from `config/app_config.yml`.

## Example

### `config/app_config.yml`

``` yaml
default: &default
  service_url: https://my_service.example.com

development:
  <<: *default

test:
  <<: *default

production:
  service_url: <%= ENV['APP_SERVICE_URL'] %>
```

### `config/environments/development.rb`

``` ruby
Rails.application.configure do
  # ...

  config.app_config = config_for(:blah).deep_symbolize_keys
end
```

### Using the configuration

``` ruby
ActionController::Base.default_url_options[:host] = Rails.configuration.app_config[:service_url]
```


