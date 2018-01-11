class StaffsController < ApplicationController
    before_action :authenticate, only: [:show,]
    before_action :check_rule, only: [:show,]
    def show
        @user = User.find_by_id(session[:current_user_id]);  
  
        @waittingproducts = Product.where(status: "Waitting")
        
        @allproducts = Product.all
  
        @users = User.where(typee: "member")

      end
    def check_rule
        cur_user = User.find_by(id: session[:current_user_id])      
        if (cur_user.typee != "staff" )
          redirect_to profile_path(cur_user.id)
        end
    end
end
