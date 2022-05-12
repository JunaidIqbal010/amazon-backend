require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AmazonBackend
  class Application < Rails::Application
    config.action_mailer.delivery_method = :postmark
    config.action_mailer.postmark_settings = { :api_token => "cee3871b-e9b8-46b0-89e6-20e54f850e0c" }
    config.action_controller.default_protect_from_forgery = true
    config.eager_load_paths << Rails.root.join('lib')
    config.autoloader = :classic
    config.load_defaults 6.0
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end
  end
end
