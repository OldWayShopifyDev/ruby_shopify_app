# frozen_string_literal: true
# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require_relative "../test/dummy/config/environment"
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../test/dummy/db/migrate", __dir__)]
ActiveRecord::Migrator.migrations_paths << File.expand_path("../db/migrate", __dir__)
require "rails/test_help"

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_paths=)
  ActiveSupport::TestCase.fixture_paths = [File.expand_path("fixtures", __dir__)]
  ActionDispatch::IntegrationTest.fixture_paths = ActiveSupport::TestCase.fixture_paths
  ActiveSupport::TestCase.file_fixture_path = File.expand_path("fixtures", __dir__) + "/files"
  ActiveSupport::TestCase.fixtures :all
end

require 'mocha/minitest'
require 'webmock/minitest'
require 'byebug'
require 'minitest/focus'
require 'ostruct'

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

Mocha.configure do |c|
  c.strict_keyword_argument_matching = true
end

class ActiveSupport::TestCase
  include GeneratorTestHelpers
  include SessionStoreStrategyTestHelpers
  include AccessScopesStrategyHelpers

  API_META_TEST_RESPONSE = <<~JSON
    {
      "apis": [{
        "handle": "admin",
        "versions": [{
          "handle": "2019-07",
          "display_name": "2019-07",
          "supported": true,
          "latest_supported": false
        },{
            "handle": "2019-10",
            "latest_supported": true,
            "display_name": "2019-10",
            "supported": true
          }]
        }]
      }
  JSON

  def before_setup
    super
    WebMock.disable_net_connect!
    WebMock.stub_request(:get, "https://app.shopify.com/services/apis.json").to_return(body: API_META_TEST_RESPONSE)
    ShopifyAppConfigurer.call
    Rails.application.reload_routes!
  end
end
