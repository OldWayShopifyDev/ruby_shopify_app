# frozen_string_literal: true

$LOAD_PATH.push(File.expand_path("../lib", __FILE__))
require "ruby_shopify_app/version"

Gem::Specification.new do |s|
  s.name        = "ruby_shopify_app"
  s.version     = ShopifyApp::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors = ["Hopper Gee"]
  s.email = ["hopper.gee@hey.com"]
  s.summary = "This gem is used to get quickly started with the Shopify API"

  s.required_ruby_version = ">= 2.6"

  s.metadata["allowed_push_host"] = "https://rubygems.org"

  s.add_runtime_dependency("browser_sniffer", "~> 2.0")
  s.add_runtime_dependency("jwt", ">= 2.2.3")
  s.add_runtime_dependency("omniauth-rails_csrf_protection")
  s.add_runtime_dependency("omniauth-shopify-app", "~> 1.0")
  s.add_runtime_dependency("rails", ">= 6.1.0")
  s.add_runtime_dependency("redirect_safely", "~> 1.0")
  s.add_runtime_dependency("ruby_shopify_api", "~> 1.2")
  s.add_runtime_dependency("sprockets-rails", ">= 2.0.0")

  s.add_development_dependency("byebug")
  s.add_development_dependency("minitest")
  s.add_development_dependency("mocha")
  s.add_development_dependency("rake")
  s.add_development_dependency("rb-readline")
  s.add_development_dependency("sqlite3", "~> 1.4")
  s.add_development_dependency("webmock")

  s.files         = %x(git ls-files).split("\n").reject { |f| f.match(%r{^(test|example)/}) }
  s.require_paths = ["lib"]
end
