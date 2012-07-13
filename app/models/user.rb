class User < ActiveRecord::Base

  rolify

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :image_url
  # attr_accessible :title, :body

  validates :email, :format => { :with => /@modcloth.com$/ }

  def self.find_for_oauth(access_token, signed_in_request=nil)
    data = access_token.info
    puts "data #{data}"
    if user = User.where(email: data["email"]).first
      user
    else
      User.create!(email: data["email"], name: data["name"], password: Devise.friendly_token[0,20], image_url: data["image"])
    end
  end

  def self.find_for_open_id(access_token, signed_in_request=nil)
    data = access_token.info
    puts "data #{data}"
    if user = User.where(:email => data["email"]).first
      user
    else
      User.create!(email: data["email"], name: data["name"], password: Devise.friendly_token[0,20])
    end
  end

end
