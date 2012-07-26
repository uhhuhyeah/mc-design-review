class Talk < ActiveRecord::Base
  belongs_to :presenter, class_name: 'User', foreign_key: :user_id
  belongs_to :co_presenter, :class_name => 'User'
  has_many :participants
  has_many :attendees, through: :participants

  attr_accessible :attend, :co_presenter_id, :date, :description, :expect, :length, :prepare, :title, :user_id, :slides_url

  validates :user_id, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :attend, presence: true
  validates :expect, presence: true

  scope :recent, Proc.new { where('date >= ? AND date <= ?', 1.week.ago.to_date, 3.weeks.from_now.to_date).group('date,id') }
  scope :tbd, where('date is null')
end
