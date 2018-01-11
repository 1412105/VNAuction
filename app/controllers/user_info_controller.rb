class UserInfoController < ApplicationController
    before_action :authenticate, only: [:new, :show, :edit, :show_edit]
    before_action :check_block, only: [:new, :show, :edit, :show_edit]
    def new
      #code
    end
    def show
      @user = User.find_by_id(params[:id]);
      if (@user.id == session[:current_user_id])
        bids = BidHistory.where(user_id: session[:current_user_id])
        bidautos = BidAuto.where(user_id: session[:current_user_id])

        prod = Array.new 
        prod2 = Array.new 
        bids.each do |b| 
          prod.push(b.product_id)

        end
        bidautos.each do |b| 
          prod2.push(b.product_id)

        end
        prod = prod|prod2

        @bidproducts = Array.new
        prod.each do |p| 
            product = Product.find(p)
            if (product)
              @bidproducts.push(product)
            end
        end


        @sellproducts = Product.where(seller_id: session[:current_user_id])

        @messages = Message.where(user_id: session[:current_user_id])

        @favorites = Favorite.where(user_id: session[:current_user_id])
      end
    end
    def show_edit
      @user = User.find_by_id(session[:current_user_id]);
    end
    def edit
      user = User.find_by_id(session[:current_user_id]);
      if user.authenticate(params[:edit_profile_params][:confirm_old_password])
          user.update(:name => params[:edit_profile_params][:name], :email => params[:edit_profile_params][:email], :address => params[:edit_profile_params][:address], :avatar => params[:edit_profile_params][:avatar])
      end
      redirect_to profile_path(session[:current_user_id]);
    end
    def edit_profile_params
      params.require(:edit_profile).permit(:name, :email, :address, :avatar, :new_password, :confirm_new_password, :confirm_old_password);
    end

    def check_block
      cur_user = User.find_by(id: session[:current_user_id])
      if (cur_user.status == "blocked" && cur_user.typee=="staff")
          redirect_to staff_path
      end

      if (cur_user.status == "blocked" && cur_user.typee=="admin")
          redirect_to admin_path
      end

      if (cur_user.status == "blocked" && cur_user.typee=="member")
          redirect_to profile_path(cur_user.id)
    end
  end
end
