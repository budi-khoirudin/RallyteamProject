class User < ApplicationRecord
  has_many :likes, dependent: :destroy

  def self.find_or_create_from_auth_hash(auth_hash)
    user = where(provider: auth_hash[:provider], uid: auth_hash[:uid]).first_or_create
    user.update(
    name: auth_hash[:info][:name],
    image_profile: auth_hash[:info][:image],
    token: auth_hash[:credentials][:token],
    secret: auth_hash.credentials.secret
    )
    user
  end

# this is the function that twitter knos when sees it how to digest it
  def twitter
      @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_api_key
      config.consumer_secret     = Rails.application.secrets.twitter_api_secret
      config.access_token        = token
      config.access_token_secret = secret
      end
  end



end
