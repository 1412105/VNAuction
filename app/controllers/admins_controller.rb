class AdminsController < ApplicationController
  before_action :authenticate, only: [:show, :create_user ]
  before_action :check_rule, only: [:show, :create_user]
    def show
        @user = User.find_by_id(session[:current_user_id]);
        @user = User.find_by_id(session[:current_user_id]);
        
                @users = User.where(typee: "member")
        
                @admins = User.where(typee: "admin")
          
                @staffs = User.where(typee: "staff")
    end
    
    def check_rule
      cur_user = User.find_by(id: session[:current_user_id])      
      if (cur_user.typee != "admin" )
        redirect_to profile_path(cur_user.id)
      end
    end

    def create_user
      name=params[:post][:name]
      email = params[:post][:email]
      password= params[:post][:password]
      rule =params[:post][:rule]

      user = User.find_by(email: email)
      if (!user)
        user = User.create!(name:name,email:email,password:password, typee:rule, status:"available")
      end
      redirect_to admin_path
    end


    #def delete_user
    #   user = User.find(params[:id])
    #  if (user)
    #    user.delete
    #    respond_to do |format|
    #      format.html { redirect_to admin_path, notice: 'Product was successfully destroyed.' }
     #     format.json { head :no_content }
    #    end
    #  end
    #end
end
