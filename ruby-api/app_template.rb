def source_paths
  [File.expand_path(File.dirname(__FILE__))]
end

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
gem 'bootsnap', require: false

group :development do
  gem 'byebug', platform: :mri
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
gem 'codekraft-api', git: 'https://github.com/TheRealCodeKraft/codekraft-ruby-api', branch: 'master'"
end

run "bundle install"

# COPY CONFIG FILES
remove_file "config/application.rb"
remove_file 'config/database.yml'
remove_file 'config/routes.rb'
directory "config"

# CREATING ENV FILE
create_file '.env'
append_to_file '.env' do
  "DATABASE_URL=postgresql://#{@app_name}:#{@app_name}@postgres/#{@app_name}"
end

# MANAGING MAILS
remove_file "app/views/layouts/mailer.html.erb"
directory "app"
gsub_file "app/views/layouts/mailer.html.erb", "[[APP_NAME]]", "#{@app_name}"
inject_into_file 'config/environments/development.rb', after: 'config.action_mailer.perform_caching = false' do <<-'RUBY'

  config.action_mailer.smtp_settings = {
    :address              => "localhost",
    :port                 => 1025
  }
RUBY
end

# GENERATING MIGRATIONS
generate "doorkeeper:migration"
generate "migration", "create_user firstname:string lastname:string email:string encrypted_password:string salt:string role:string cgu:boolean timestamps:timestamps no_password:boolean stamp:string stamp_expiration:timestamp stamp_salt:string"
generate "migration", "create_post type:string title:string slug:string payload:json user_id:integer author_name:string published_at:datetime uid:string timestamps:timestamps"

uid = SecureRandom.uuid
secret = SecureRandom.uuid
token = SecureRandom.uuid
admin_pass = SecureRandom.uuid

# GENERATING SEEDING SCRIPT
remove_file 'db/seeds.rb'
directory "db"
gsub_file "db/seeds.rb", "[[APP_NAME]]", "#{@app_name}"
gsub_file "db/seeds.rb", "[[SECRET]]", "#{secret}"
gsub_file "db/seeds.rb", "[[UID]]", "#{uid}"
gsub_file "db/seeds.rb", "[[TOKEN]]", "#{token}"
gsub_file "db/seeds.rb", "[[ADMIN_PASS]]", "#{admin_pass}"

append_to_file '.codekraftrc' do
"app_name\t\t#{@app_name}
app_redirect_url\thttps://www.#{@app_name}.com/callback
app_key\t\t\t#{uid}
app_secret\t\t#{secret}
base_token\t\t#{token}
admin_mail\t\tgod@#{@app_name}.com
admin_password\t\t#{admin_pass}"
end
create_file '.frontend.env'
append_to_file '.frontend.env' do
"CLIENT_ID=#{uid}
CLIENT_SECRET=#{secret}
APP_TOKEN=#{token}
API_URL=http://localhost:3000/v1/
CLIENT_GRANT_TYPE=client_credentials
CABLE_URL=http://localhost:3000/cable"
end

# MIGRATE AND SEED DATABASE
rake "db:migrate db:seed"

# CREATE CODEKRAFT INITIALIZER
gsub_file "config/initializers/codekraft.rb", "[[APP_NAME]]", "#{@app_name}"

# MANAGE GIT REPO
#if yes? "Do you wish to use Git ? (y/n)"
#  git :init
#  git add: '--all', commit: '-m "Initial Commit"'
#  if yes? "Do you wish to push the created code on a remote git repo ? (y/n)"
#    repo = ask("Give me the repo url : ").underscore
#  end
#end
