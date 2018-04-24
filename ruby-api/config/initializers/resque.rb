Resque.redis = (Rails.env.staging? or Rails.env.production?) ? ENV['REDISCLOUD_URL'] : "redis://redis:6379"
