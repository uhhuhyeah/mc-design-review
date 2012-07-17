class Participant < ActiveRecord::Base
  attr_accessible :talk_id, :user_id
  belongs_to :attendee, class_name: 'User', foreign_key: 'user_id'
  belongs_to :talk
end
