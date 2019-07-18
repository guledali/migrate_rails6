class Community < ApplicationRecord
  belongs_to :user
  has_many :submissions

  has_many :subscriptions
  has_many :users, through: :subscriptions

  before_save :format_name

  def format_name
    self.name.titleize
    self.name.gsub!(' ','')
  end
end
