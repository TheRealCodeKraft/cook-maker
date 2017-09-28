# CREATING CODEKRAFT RC FILE
create_file '.codekraftrc'

# MANAGING GEMS
remove_file 'Gemfile'
create_file 'Gemfile'
append_to_file 'Gemfile' do
"source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = \"\#{repo_name}/\#{repo_name}\" unless repo_name.include?(\"/\")
  \"https://github.com/\#{repo_name}.git\"
end

gem 'rails', '~> 5.0.5'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'jbuilder', '~> 2.5'

group :development do
  gem 'byebug', platform: :mri
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
gem 'codekraft-api', git: 'https://github.com/TheRealCodeKraft/codekraft-ruby-api', branch: 'master'"
end

# REQUIRE SOME LIBRARIES
remove_file 'config/application.rb'
create_file 'config/application.rb'
append_to_file 'config/application.rb' do <<-'RUBY'
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
    config.active_record.raise_in_transactional_callbacks = true

  end
end
RUBY
end

# CREATE CODEKRAFT INITIALIZER
initializer "codekraft.rb" do <<-'RUBY'
Codekraft::Api.configure do |config|
  config.resources =  {
  }
end
RUBY
end

# CREATING ENV FILE
create_file '.env'
append_to_file '.env' do
  "DATABASE_URL=postgresql://#{@app_name}:#{@app_name}@localhost/#{@app_name}"
end

# CREATING DATABASE CONFIG
remove_file 'config/database.yml'
create_file 'config/database.yml'
append_to_file 'config/database.yml' do
"default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch('RAILS_MAX_THREADS') { 5 } %>
  url: <%= ENV['DATABASE_URL'] %>
development:
  <<: *default
test:
  <<: *default
  url: <%= ENV['DATABASE_TEST_URL'] %>
production:
  <<: *default"
end

# GENERATING DOORKEEPER
generate "doorkeeper:install"
generate "doorkeeper:migration"

# GENERATING USER MIGRATION
generate "migration", "create_user firstname:string lastname:string email:string encrypted_password:string salt:string role:string cgu:boolean timestamps:timestamps no_password:boolean"

uid = SecureRandom.uuid
secret = SecureRandom.uuid
token = SecureRandom.uuid
redirect_url = "https://www.#{@app_name}.com/callback"
admin_mail = "god@#{@app_name}.com"
admin_pass = SecureRandom.uuid

# GENERATING SEEDING SCRIPT
append_to_file 'db/seeds.rb' do
"app = Doorkeeper::Application.create! :name => '#{@app_name}', 
                                      :redirect_uri => '#{redirect_url}', 
                                      scopes: '', 
                                      uid: '#{uid}', 
                                      secret: '#{secret}'
access_token = Doorkeeper::AccessToken.create!(:application_id => app.id, 
                                               expires_in: nil, 
                                               scopes: 'app')
access_token.token = '#{token}'
access_token.save

Codekraft::Api::Service::User.new.create({
  firstname: 'God',
  lastname: 'Admin',
  email: '#{admin_mail}',
  password: '#{admin_pass}',
  password_confirm: '#{admin_pass}',
  role: 'admin'
})
"
end
append_to_file '.codekraftrc' do
"app_name\t\t#{@app_name}
app_redirect_url\t#{redirect_url}
app_key\t\t\t#{uid}
app_secret\t\t#{secret}
base_token\t\t#{token}
admin_mail\t\t#{admin_mail}
admin_password\t\t#{admin_pass}"
end
create_file '.frontend.env'
append_to_file '.frontend.env' do
"CLIENT_ID=#{uid}
CLIENT_SECRET=#{secret}
APP_TOKEN=#{token}
API_URL=http://localhost:3100/v1/
CLIENT_GRANT_TYPE=client_credentials
CABLE_URL=http://localhost:3100/cable"
end

# MIGRATE AND SEED DATABASE
rake "db:migrate db:seed"

# CREATE DOORKEEPER INITIALIZER
remove_file 'config/initializers/doorkeeper.rb'
create_file 'config/initializers/doorkeeper.rb'
append_to_file 'config/initializers/doorkeeper.rb' do <<-'RUBY'
Doorkeeper.configure do
  orm :active_record

  resource_owner_from_credentials do |routes|
    service = Codekraft::Api::Service::User.new
    user = Codekraft::Api::Model::User.find_by(:email => params[:email].downcase)
    if user
      encrypted = 
      if service.encrypt_password(params[:password], user.salt) == user.encrypted_password
        user
      elsif user.stamp
        if user.stamp_expiration > DateTime.now and service.encrypt_password(params[:password], user.stamp_salt) == user.stamp
          user
        end
      end
    end 
  end

  admin_authenticator do
    Codekraft::Api::Model::User.find_by_id(session[:user_id]) || warden.authenticate!(scope: user)
  end

  access_token_expires_in 24.hours

  use_refresh_token
end

Doorkeeper.configuration.token_grant_types << "password" 
RUBY
end

# CREATE BASE API ENDPOINT
create_file 'app/api/base.rb'
append_to_file 'app/api/base.rb' do <<-'RUBY'
class Base < Grape::API
  mount V1::Base
end
RUBY
end

create_file 'app/api/v1/base.rb'
append_to_file 'app/api/v1/base.rb' do <<-'RUBY'
require 'doorkeeper/grape/helpers' 
require "grape-swagger"
require "grape-swagger-representable"

module V1
  class Base < Grape::API

      include Codekraft::Api::Defaults
      helpers Doorkeeper::Grape::Helpers
      include Codekraft::Api::Endpoint

  end
end
RUBY
end

# MANAGING ROUTES
remove_file 'config/routes.rb'
create_file 'config/routes.rb'
append_to_file 'config/routes.rb' do <<-'RUBY'
Rails.application.routes.draw do
  scope 'v1' do
    use_doorkeeper
  end
  mount Base, at: "/"
  mount GrapeSwaggerRails::Engine => '/docs'
end
RUBY
end

# MANAGE GIT REPO
#if yes? "Do you wish to use Git ? (y/n)"
#  git :init
#  git add: '--all', commit: '-m "Initial Commit"'
#  if yes? "Do you wish to push the created code on a remote git repo ? (y/n)"
#    repo = ask("Give me the repo url : ").underscore
#  end
#end
