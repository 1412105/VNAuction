module UsersHelper
	def flash_class(key)
		case key
		when "success"
			"alert-info"
		when "error"
			"alert-danger"
		end
	end
end
