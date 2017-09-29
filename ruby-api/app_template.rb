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
initializer "codekraft.rb" do
"Codekraft::Api.configure do |config|
  config.prod_url = 'http://www.#{@app_name}.com'
  config.default_mail_from = 'hello@#{@app_name}.com'
  config.resources =  {
  }
end"
end

# CREATE BASE MAIL LAYOUTS
remove_file 'app/views/layouts/mailer.html.erb' 
create_file 'app/views/layouts/mailer.html.erb' 
append_to_file 'app/views/layouts/mailer.html.erb' do
"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional //EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">
<html>
  <head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"user-scalable=no, initial-scale=1, minimum-scale=1, maximum-scale=1, width=device-width\">
    <title>PartNurse</title>
    <style type=\"text/css\">
      @media only screen and (max-width: 800px){
        td[class=\"fullhide\"]{display: block !important;width:auto !important;max-height:inherit !important;overflow:visible !important; float:none !important;}
        table[class=\"w800\"]{width:320px !important; } 
        td[class=\"desktop\"], img[class=\"desktop\"], br[class=\"desktop\"]{display: none !important;}
        td[class=\"mobile\"], img[class=\"mobile\"], br[class=\"mobile\"], td[class=\"block\"]{display: block !important;}
        td[class=\"h20\"] img{height: 10px !important;}
        td[class=\"h30\"] img{height: 20px !important;}
        td[class=\"h40\"] img{height: 30px !important;}
        td[class=\"w20\"]{width: 10px !important;}
      }
    </style>
  </head>
  <body style=\"margin:0; padding:10px; background-color:#F5F5F5\">
    <table width=\"800\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" class=\"w800\"  bgcolor=\"#F5F5F5\">
      <tr>
        <td style=\"font-family:Arial,Helvetica,sans-serif; font-size:12px;\" bgcolor=\"#e8e8e8\">
          <a href=\"https://playground.openbusinesslabs.com\" target=\"_blank\">
            #{@app_name}
          </a>
        </td>
      </tr>
      <tr>
        <td style=\"font-family:Arial,Helvetica,sans-serif; font-size:12px;\">
          <table width=\"800\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" class=\"w800\">
            <tr>
              <td style=\"padding:16px; background:#FFFFFF;\">
                <div style=\"text-align: right;\">
                  <span>le <%= DateTime.now.strftime(\"%d/%m/%Y\") %></span>
                </div>
              </td>
            </tr>
            <tr>
              <td>
                <!--<img src=\"img/img-cut.png\" alt=\"\" style=\"display:block; border:0; width:100%;\" />-->
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td>
          <table width=\"800\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" class=\"w800\">
            <tr>
              <td>
                <%= image_tag \"https://media.openbusinesslabs.com/mails/spacer.gif\", width: \"44\", height: \"100%\", style: \"display: block\" %>
              </td>
              <td style=\"font-family:Arial,Helvetica,sans-serif; font-size:16px; color:#87919b; padding-top: 10px;\">
                Bonjour<%= (not @user.firstname.nil?) ? \" \#{@user.firstname}\" : \"\" %>,
                <%= yield %>
                <p>
                  
                </p>
                <p>
                  <br />
                  A bientôt sur OpenBusinessLabs,
                  <br />
                </p>
              </td>
              <td>
                <%= image_tag \"https://media.openbusinesslabs.com/mails/spacer.gif\", width: \"30\", height: \"100%\", style: \"display: block;\" %>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td>
          <table width=\"800\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" class=\"w800\" bgcolor=\"#232d37\">
            <tr>
              <td>
                <%= image_tag \"https://media.openbusinesslabs.com/mails/spacer.gif\", width: \"8\", height: \"44\", style: \"display: block;\" %>
              </td>
              <td align=\"left\" style=\"font-family:Arial,Helvetica,sans-serif;font-size:12px;color:#FFFFFF;\">
                Open Business Labs
              </td>
              <td align=\"right\" style=\"font-family: Arial, Helvetica, sans-serif;font-size:12px;\">
                <%#<a href=\"mailto:contact@partnurse.com\" target=\"_blank\" style=\"color:#FFFFFF\">Nous contacter</a>#%>
              </td>
              <td>
                <%= image_tag \"https://media.openbusinesslabs.com/mails/spacer.gif\", width: \"8\", height: \"44\", style: \"display: block;\" %>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td>
          <table width=\"800\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" class=\"w800\" bgcolor=\"#f6f6f6\">
            <tr>
              <td style=\"font-family:Arial,Helvetica,sans-serif;font-size:11px;color:#FFFFFF;padding:8px;\" align=\"center\" bgcolor=\"#0f1923\">
                <%#
                  Pour ne plus recevoir de messages de notre part, il vous suffit de <a href=\"/\" target=\"_blank\" style=\"color:#FFFFFF\">cliquer ici</a>.
                  #%>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </body>
</html>"
end
remove_file 'app/views/layouts/mailer.text.erb' 
create_file 'app/views/layouts/mailer.text.erb' 
append_to_file 'app/views/layouts/mailer.text.erb' do
"<%= yield %>"
end
create_file 'app/views/codekraft/api/mailer/invitation_mailer/invite.html.erb'
append_to_file 'app/views/codekraft/api/mailer/invitation_mailer/invite.html.erb' do
"<p>Vous avez été invité à rejoindre le site</p>
<p>Rendez-vous ensemble en cliquant <a href=\"<%= @url %>\">ici</a></p>"
end
inject_into_file 'config/environments/development.rb', after: 'config.action_mailer.perform_caching = false' do <<-'RUBY'

  config.action_mailer.smtp_settings = {
    :address              => "localhost",
    :port                 => 1025
  }
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
generate "migration", "create_user firstname:string lastname:string email:string encrypted_password:string salt:string role:string cgu:boolean timestamps:timestamps no_password:boolean stamp:string stamp_expiration:timestamp stamp_salt:string"

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
      if not user.salt.nil? and service.encrypt_password(params[:password], user.salt) == user.encrypted_password
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
