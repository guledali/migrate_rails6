class User < ApplicationRecord
  extend FriendlyId
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :subscriptions
  has_many :communities, through: :subscriptions
  has_many :submissions
  has_many :comments

  validates_uniqueness_of :username
  validates_presence_of :username

  has_many :subscribed_submissions, through: :communities, source: :submissions

  acts_as_voter

  friendly_id :username, use: :slugged

  private
    def add_unsubscribe_hash
      self.unsubscribe_hash = SecureRandom.hex
    end
end
