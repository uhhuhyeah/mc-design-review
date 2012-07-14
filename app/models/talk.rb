class Talk < ActiveRecord::Base
  belongs_to :user
  belongs_to :co_presenter, :class_name => 'User'
  attr_accessible :attend, :co_presenter_id, :date, :description, :expect, :length, :prepare, :title, :user_id

  validates :user_id, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :attend, presence: true
  validates :expect, presence: true
end
