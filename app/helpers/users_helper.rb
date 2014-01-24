module UsersHelper
	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		# gravatar_url = "https://secure.gravatar.com/avatars/#{gravatarid}.png"
		gravatar_url = user.image_base64
		image_tag(gravatar_url, alt: user.name, class: 'gravatar')
	end
end
