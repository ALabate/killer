require "http"

module ApplicationHelper

	def user_image(image_uri,width= 100)
		base_site = "https://etu.utt.fr/"
		image_tag(base_site+image_uri, width: width, class: "thumbnail")
	end

end
