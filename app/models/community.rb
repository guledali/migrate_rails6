class Community < ApplicationRecord
  belongs_to :user
  has_many :submissions

  has_many :subscriptions
  has_many :users, through: :subscriptions

  before_save :format_name

  extend FriendlyId
  friendly_id :title, use: :slugged

  def format_name
    self.name.titleize
    self.name.gsub!(' ','')
  end
end
