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

