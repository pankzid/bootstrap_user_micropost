module ApplicationHelper
	def full_title title
		base_title = 'Bootstrap User Micropost'
		if title
			"#{base_title}: #{title}"
		else
			base_title
		end
	end
end
