require_relative "boot"

require "rails/all"
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
require "ruby_shopify_app"

module Dummy
  class Application < Rails::Application

    config.load_defaults Rails::VERSION::STRING.to_f

    # config.autoload_lib(ignore: %w(assets tasks))

  end
end
