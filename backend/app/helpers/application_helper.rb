module ApplicationHelper
    def avatar_url(user, size: 80)
        gravatar_id  = Digest::MD5::hexdigest(user.email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        return gravatar_url
    end
end
