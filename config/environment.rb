# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# This reads in config/foo.yml and selects the values for the
# appropriate rails environment, then assigns them to the
# configuration key `foo`. Values will be avaiable via
# Rails.configuration.foo[]

Rails.configuration.foo = Rails.application.config_for(:foo).deep_symbolize_keys
