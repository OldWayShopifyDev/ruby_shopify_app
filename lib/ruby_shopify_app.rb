# frozen_string_literal: true

require "ruby_shopify_app/version"

# deps
require "ruby_shopify_api"
require "omniauth/rails_csrf_protection"
require "omniauth-shopify-app"
require "redirect_safely"

module ShopifyApp
  def self.rails6?
    Rails::VERSION::MAJOR >= 6
  end

  def self.rails7?
    Rails::VERSION::MAJOR >= 7
  end

  def self.use_importmap?
    rails7? && File.exist?("config/importmap.rb")
  end

  def self.use_webpacker?
    rails6? &&
      defined?(Webpacker) == "constant" &&
      !configuration.disable_webpacker
  end

  # config
  require "ruby_shopify_app/configuration"

  # engine
  require "ruby_shopify_app/engine"

  # utils
  require "ruby_shopify_app/utils"

  # controller concerns
  require "ruby_shopify_app/controller_concerns/csrf_protection"
  require "ruby_shopify_app/controller_concerns/localization"
  require "ruby_shopify_app/controller_concerns/itp"
  require "ruby_shopify_app/controller_concerns/login_protection"
  require "ruby_shopify_app/controller_concerns/embedded_app"
  require "ruby_shopify_app/controller_concerns/payload_verification"
  require "ruby_shopify_app/controller_concerns/app_proxy_verification"
  require "ruby_shopify_app/controller_concerns/webhook_verification"

  # jobs
  require "ruby_shopify_app/jobs/webhooks_manager_job"
  require "ruby_shopify_app/jobs/scripttags_manager_job"

  # managers
  require "ruby_shopify_app/managers/webhooks_manager"
  require "ruby_shopify_app/managers/scripttags_manager"

  # middleware
  require "ruby_shopify_app/middleware/jwt_middleware"
  require "ruby_shopify_app/middleware/same_site_cookie_middleware"

  # session
  require "ruby_shopify_app/session/in_memory_session_store"
  require "ruby_shopify_app/session/in_memory_shop_session_store"
  require "ruby_shopify_app/session/in_memory_user_session_store"
  require "ruby_shopify_app/session/jwt"
  require "ruby_shopify_app/session/null_user_session_store"
  require "ruby_shopify_app/session/session_repository"
  require "ruby_shopify_app/session/session_storage"
  require "ruby_shopify_app/session/shop_session_storage"
  require "ruby_shopify_app/session/shop_session_storage_with_scopes"
  require "ruby_shopify_app/session/user_session_storage"
  require "ruby_shopify_app/session/user_session_storage_with_scopes"

  # access scopes strategies
  require "ruby_shopify_app/access_scopes/shop_strategy"
  require "ruby_shopify_app/access_scopes/user_strategy"
  require "ruby_shopify_app/access_scopes/noop_strategy"

  # omniauth_configuration
  require "ruby_shopify_app/omniauth/omniauth_configuration"
end
