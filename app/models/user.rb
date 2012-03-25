class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :access_token

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user
    else # Create a user with a stub password. 
      User.create!(:email => data.email, 
                   :password => Devise.friendly_token[0,20],
                   :access_token => access_token.credentials.token)
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
        user.access_token = session["devise.facebook_data"]["credentials"]["token"]
      end
    end
  end
end
