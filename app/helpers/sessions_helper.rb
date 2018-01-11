module SessionsHelper
	def flash_class(key)
		case key
		when "success"
			"alert-info"
		when "error"
			"alert-danger"
		end
    end

    def current_user
		@current_user ||= User.find_by(id: session[:current_user_id])
	end

	def authenticate
        if session[:current_user_id].nil?
        	redirect_to login_path
    	end
  	end

  	def login(user)
		session[:current_user_id] = user.id
	end

	def logout
		session.delete(:current_user_id)
	end
end
