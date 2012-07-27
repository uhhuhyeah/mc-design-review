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

  has_many :talks

  def is_attending?(talk)
    talk.attendees.include?(self)
  end

  def image
    image_url || 'http://placekitten.com/100/100'
  end

  def self.find_for_oauth(auth_hash, signed_in_request=nil)
    data = auth_hash.info
    if user = User.where(email: data["email"]).first
      user
    else
      User.create!(email: data["email"], name: data["name"], password: Devise.friendly_token[0,20], image_url: data["image"])
    end
  end

  def self.find_for_open_id(auth_hash, signed_in_request=nil)
    data = auth_hash.info
    if user = User.where(:email => data["email"]).first
      user
    else
      User.create!(email: data["email"], name: data["name"], password: Devise.friendly_token[0,20])
    end
  end

  def self.find_for_developer(auth_hash, signed_in_request)
    where(auth_hash.slice(:email)).first_or_create do |user|
      user.name = auth_hash.info.name
      user.email = auth_hash.email
      user.password = Devise.friendly_token[0,20]
    end
  end

end
