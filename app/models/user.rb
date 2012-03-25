class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible nil
end
