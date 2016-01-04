module UsersHelper
  def gravatar_for user
    g_id=user.email.downcase
    g_url="https://secure.gravatar.com/avatar/#{g_id}"
    image_tag g_url,alt:user.name,class:"gravatar"
  end
end
