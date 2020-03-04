#app/services/oauth_service.rb
class OauthService
  attr_reader :auth_hash

  def initialize(auth_hash)
    @auth_hash = auth_hash
  end

  def create_oauth_account!
    oauth_account = nil
    existing_user = User.where(uid: @auth_hash[:uid]).first
    if existing_user
      puts "Returning User Log In"
      oauth_account = existing_user
    else
      puts "New User Log In"
      oauth_account = User.create!(oauth_account_params)
    end

    puts "Returned User"
    puts oauth_account.to_yaml
    oauth_account
  end

private
  def oauth_account_params
    print(@auth_hash.to_yaml)
    { uid: @auth_hash[:uid],
      provider: @auth_hash[:provider],
      image_url: @auth_hash[:info][:picture_url],
      first_name: @auth_hash[:info][:first_name],
      last_name: @auth_hash[:info][:last_name],
      email: @auth_hash[:info][:email],
      access_token: @auth_hash[:credentials][:token]
    }
  end
end
