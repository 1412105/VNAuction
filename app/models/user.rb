class User < ApplicationRecord
	has_secure_password
    has_many :bid_autos
    has_many :favorites
    has_many :bid_historys
	mount_uploader :avatar, AvatarUploader
	
    def self.authenticate!(session_params)
		user = User.authenticate(session_params)

		if user.nil?
			raise RecordNotFound
		else
			user
		end
	end

    def self.authenticate(session_params)
        user = User.find_by(email: session_params[:email])
        if user.nil?
			raise RecordNotFound
		else

            if user.authenticate(session_params[:password])
                user
            else
                false
            end
        end
    end

    def self.authenticate?(session_params)
        !User.authenticate(session_params).nil?
    end
end
