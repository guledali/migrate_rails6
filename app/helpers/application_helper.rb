module ApplicationHelper
    def render_svg(name, styles: "fill-current text-gray-400", title: nil)
        filename = "#{name}.svg"
        title || name.underscore.humanize
        inline_svg(filename, aria: true, nocomment: true, title: title, class: styles)
    end

    # @return [User]
    def current_user
        super
    end

    def inject_feed_ad(index)
        if((index + 1) % 3 == 0 )
            render "application/feed_ad"
        end
    end

    def active_subscriber?
        user_signed_in? && current_user.subscribed?
    end

end
