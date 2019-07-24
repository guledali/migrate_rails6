class SubmissionMailer < ApplicationMailer
  default from: 'guled@gmail.com'

  def new_response
    @comment = params[:comment]
    @submission = params[:submission]

    if @submission.user.comment_subscription?
      mail(to: @submission.user.email, subject: "New response on: #{@submission.title}" )
    end
  end
end
