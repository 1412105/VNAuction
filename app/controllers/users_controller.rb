class UsersController < ApplicationController
    before_action :authenticate, only: [:unblock, :block]
    before_action :check_block, only: [:unblock, :block]

    def new
    end
    
    def create
            user = User.find_by(email: user_params[:email])
            if user
                flash[:error] = "Cannot register new account."
                render :new
            else
                user = User.create(user_params)
                if user
                    user.status = "available"
                    user.typee = "member"
                    user.save
                    flash[:success] = "Register successfully."
                    redirect_to login_path
                else
                    flash[:error] = "Cannot register new account."
                    render :new
                end
            end
        end

    def block
        cur_user = User.find_by(id: session[:current_user_id])
        if (cur_user.typee == "staff" )
            user = User.find(params[:id])
            if (user)
                user.status = "blocked"
                user.save
            end
            redirect_to staff_path
        else
            if (cur_user.typee == "admin")
                user = User.find(params[:id])
                if (user)
                    user.status = "blocked"
                    user.save
                end
                redirect_to admin_path
            else
                redirect_to profile_path(cur_user.id)
             end
        end
    end 

    def unblock
        cur_user = User.find_by(id: session[:current_user_id])
        if (cur_user.typee == "staff" )
            user = User.find(params[:id])
            if (user)
                user.status = "available"
                user.save
            end
            redirect_to staff_path
        else
            if (cur_user.typee == "admin")
                user = User.find(params[:id])
                if (user)
                    user.status = "available"
                    user.save
                end
                redirect_to admin_path
            else
                redirect_to profile_path(cur_user.id)
             end
        end
    end


    def user_params
            params.require(:user).permit(:name, :email, :password)
    end 
    def check_block
        cur_user = User.find_by(id: session[:current_user_id])
        if (cur_user.status == "blocked" && cur_user.typee=="staff")
            redirect_to staff_path
        end

        if (cur_user.status == "blocked" && cur_user.typee=="admin")
            redirect_to admin_path
        end
    end
end
