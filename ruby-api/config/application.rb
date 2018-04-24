require_relative 'boot'

require 'rails/all'
require 'rack/cors'
require 'doorkeeper'
require 'dotenv'
require 'grape'
require 'grape-active_model_serializers'
require 'grape-swagger-rails'
require 'bcrypt'
require 'colorize'
require 'redis'
require 'resque'
require 'paperclip'
require 'active_storage'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv.load()

module OblApi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.middleware.use Rack::Cors do
      allow do
        origins "*"
        resource "*", headers: :any, methods: [:get, 
            :post, :put, :delete, :options]
      end
    end

  end
end

