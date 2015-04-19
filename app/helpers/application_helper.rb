require "http"

module ApplicationHelper

	def user_image(user_data)
		base_site = "https://etu.utt.fr/"
		user_image_uri = user_data['_links'].detect{|link| link["rel"] == "user.image"}["uri"]
		image_tag(base_site+user_image_uri, width: 100, class: "thumbnail")
	end

end
