class Submission < ApplicationRecord
    include VotesCountable
    mount_uploader :submission_image, SubmissionImageUploader
    mount_uploader :submission_video, SubmissionVideoUploader

    belongs_to :user
    belongs_to :community

    has_many :comments, dependent: :destroy

    validates :title, presence: true
    validates :body, length: { maximum: 8000 }
    validates :url, url: true, allow_blank: true

    acts_as_votable

end
