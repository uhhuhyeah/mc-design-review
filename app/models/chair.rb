class Chair < ActiveRecord::Base
  attr_accessible :user_id
  
  belongs_to :user
  
  def self.current
    self.last
  end
end
