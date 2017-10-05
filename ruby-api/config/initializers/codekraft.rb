Codekraft::Api.configure do |config|
  config.prod_url = 'http://www.[[APP_NAME]].com'
  config.default_mail_from = 'hello@[[APP_NAME]].com'
  config.resources =  {
  }
end
