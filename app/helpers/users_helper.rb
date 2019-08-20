module UsersHelper
  def gravatar_for(user, styles: "rounded-full")
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.username, class: styles)
  end

  def author_of(record)
    user_signed_in? && current_user.id === record.user_id ||
        user_signed_in? && current_user.admin?
  end
end
