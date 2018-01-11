class ProductsController < ApplicationController
    before_action :authenticate, only: [:new, :create, :edit, :update, :destroy, :bid, :buynow, :like, :dislike, :end, :accept, :decline]
    before_action :set_product, only: [:show, :edit, :update, :destroy, :bid, :buynow, :end, :accept, :decline]
    before_action :check_seller, only: [:edit, :update, :end, :destroy]
    before_action :check_block, only: [:show, :new, :create, :edit, :update, :destroy, :bid, :buynow, :like, :dislike, :end, :accept, :decline]
    
      # GET /products
      # GET /products.json
      def index
        @products = Product.where.not(status: "Waitting")
        @products = @products.find_all { |pro| pro.status != "Declined"}
        @phones = @products.find_all { |pro| pro.category == "Phone"}
        @computers = @products.find_all { |pro| pro.category == "Computer"}
        @foods = @products.find_all { |pro| pro.category == "Food"}
        @beverages = @products.find_all { |pro| pro.category == "Beverage"}
        @vehicles = @products.find_all { |pro| pro.category == "Vehicle"}
        @books = @products.find_all { |pro| pro.category == "Book"}
        @clothes = @products.find_all { |pro| pro.category == "Clothe"}
        @furnitures = @products.find_all { |pro| pro.category == "Furniture"}
      end

      def search
        content = params[:post][:content]
        words = content.split(" ")
        @products = Array.new 
        if (words.count > 0)
          words.each do |w| 
              @results = Product.where('name LIKE ?', "%#{w}%").all
              @products = @products|@results
          end
        else
          @products = Product.all
        end 

        cate = params[:post][:category]
        if (cate!="none")
          @products = @products.find_all { |pro| pro.category == cate }
        end
        @products = @products.find_all { |pro| pro.status != "Waitting"}
        @products = @products.find_all { |pro| pro.status != "Declined"}
      end

      def bid
        @t1 = DateTime.now.in_time_zone("Hanoi")
        @t2 = @product.end_time.in_time_zone("Hanoi") 
         
        if (@product.status == "Bidding")
          if (@t1 < @t2) 
            price = params[:post][:price].to_i
            auto = params[:post][:auto]
            accept_price = @product.current_price + @product.rising_price
            if (price >= accept_price)
              if (auto=="auto")
                b = BidAuto.find_by(user_id: session[:current_user_id], product_id: params[:id])
                if (b)
                  b.price=price;
                  b.save
                else
                  b=BidAuto.new(user_id: session[:current_user_id], product_id: params[:id], price: price)
                  b.save
                end
              else
                b = BidHistory.find_by(user_id: session[:current_user_id], product_id: params[:id])
                if (b)
                  b.price=price;
                  b.save
                else
                  b=BidHistory.new(user_id: session[:current_user_id], product_id: params[:id], price: price)
                  b.save
                end
              end
              if (@product.max_price == @product.current_price)
                @product.max_price = price
                @product.winner = session[:current_user_id]
                @product.save
              else
                if (price > @product.max_price)
                  @product.current_price = @product.max_price + @product.rising_price
                  @product.max_price = price
                  @product.winner = session[:current_user_id]
                  @product.save
                else
                  @product.current_price = price + @product.rising_price
                  @product.save
                end
              end
            end 

            m = Message.find_by(user_id: @product.winner, product_id: params[:id])
            if (m)
              m.content = "You are the highest bidder!!"
              m.typee = "bid"
              m.save
            else
              m=Message.new(user_id:  @product.winner, product_id: params[:id], typee: "bid")
              m.content = "You are the highest bidder!!"
              m.save
            end

            bids = BidHistory.where(product_id: params[:id])
            bidautos = BidAuto.where(product_id: params[:id])
            bids.each do |b| 
                  if (b.user_id!=@product.winner)
                    m = Message.find_by(user_id: b.user_id, product_id: params[:id])
                    if (m)
                      m.content = "You are not the highest bidder!!"
                      m.typee = "bid"
                      m.save
                    else
                      m=Message.new(user_id: b.user_id, product_id: params[:id], typee: "bid")
                      m.content = "You are not the highest bidder!!"
                      m.save
                    end
                  end
            end
            bidautos.each do |b| 
                  if (b.user_id!=@product.winner)
                    m = Message.find_by(user_id: b.user_id, product_id: params[:id])
                    if (m)
                      m.content = "You are not the highest bidder!!"
                      m.typee = "bid"
                      m.save
                    else
                      m=Message.new(user_id: b.user_id, product_id: params[:id], typee: "bid")
                      m.content = "You are not the highest bidder!!"
                      m.save
                    end
                  end
            end
          else
            @product.status="Ended"
            @product.save
            m = Message.find_by(user_id: @product.winner, product_id: params[:id])
            if (m)
              m.content = "You win!!"
              m.typee = "win"
              m.save
            else
              m=Message.new(user_id:  @product.winner, product_id: params[:id], typee: "win")
              m.content = "You win!!"
              m.save
            end
    
            bids = BidHistory.where(product_id: params[:id])
            bidautos = BidAuto.where(product_id: params[:id])
            bids.each do |b| 
                  if (b.user_id!=@product.winner)
                    m = Message.find_by(user_id: b.user_id, product_id: params[:id])
                    if (m)
                      m.content = "You lose!!"
                      m.typee = "lose"
                      m.save
                    else
                      m=Message.new(user_id: b.user_id, product_id: params[:id], typee: "lose")
                      m.content = "You lose!!"
                      m.save
                    end
                  end
            end
            bidautos.each do |b| 
                  if (b.user_id!=@product.winner)
                    m = Message.find_by(user_id: b.user_id, product_id: params[:id])
                    if (m)
                      m.content = "You lose!!"
                      m.typee = "lose"
                      m.save
                    else
                      m=Message.new(user_id: b.user_id, product_id: params[:id], typee: "lose")
                      m.content = "You lose!!"
                      m.save
                    end
                  end
            end
          end
        end

        redirect_to product_path(params[:id])
      end


      

      def buynow
        cur_user = User.find_by(id: session[:current_user_id])
        if (cur_user)
          @t1 = DateTime.now.in_time_zone("Hanoi")
          @t2 = @product.end_time.in_time_zone("Hanoi") 
          if (@t1 < @t2) 
            b = BidAuto.find_by(user_id: session[:current_user_id], product_id: params[:id])
            if (b)
              b.price=@product.buy_now_price
              b.save
            else
              b=BidAuto.new(user_id: session[:current_user_id], product_id: params[:id], price: @product.buy_now_price)
              b.save
            end
            @product.winner = session[:current_user_id]
            @product.current_price = @product.buy_now_price
            @product.max_price = @product.buy_now_price;
            @product.hours_to_bid = 0
            @product.end_time = DateTime.now.in_time_zone("Hanoi")
            @product.status="Ended"
            @product.can_edit = false;
            @product.save
            m = Message.find_by(user_id: @product.winner, product_id: params[:id])
            if (m)
              m.content = "You win!!"
              m.typee = "win"
              m.save
            else
              m=Message.new(user_id:  @product.winner, product_id: params[:id], typee: "win")
              m.content = "You win!!"
              m.save
            end
    
            bids = BidHistory.where(product_id: params[:id])
            bidautos = BidAuto.where(product_id: params[:id])
            bids.each do |b| 
                  if (b.user_id!=@product.winner)
                    m = Message.find_by(user_id: b.user_id, product_id: params[:id])
                    if (m)
                      m.content = "You lose!!"
                      m.typee = "lose"
                      m.save
                    else
                      m=Message.new(user_id: b.user_id, product_id: params[:id], typee: "lose")
                      m.content = "You lose!!"
                      m.save
                    end
                  end
            end
            bidautos.each do |b| 
                  if (b.user_id!=@product.winner)
                    m = Message.find_by(user_id: b.user_id, product_id: params[:id])
                    if (m)
                      m.content = "You lose!!"
                      m.typee = "lose"
                      m.save
                    else
                      m=Message.new(user_id: b.user_id, product_id: params[:id], typee: "lose")
                      m.content = "You lose!!"
                      m.save
                    end
                  end
            end
    
          end
        end

        
        redirect_to product_path(params[:id])
      end
      # GET /products/1
      # GET /products/1.json
      def show
        @cur_user = User.find_by(id: session[:current_user_id])
        if (@product.status != "Waitting" || @cur_user.typee == "staff" || @cur_user.typee == "staff" || @cur_user.id == @product.seller_id)
          @order_item = current_order.order_items.new
          @seller = User.find_by(id: @product.seller_id)
          @cur_user = User.find_by(id: session[:current_user_id])
          @check=false;
          @isLogin=false;
          #@time = @product.created_at.utc.to_datetime - 8.hours + @product.hours_to_bid.hours
          if (@product.end_time) 
            @time = @product.end_time.in_time_zone("Hanoi")- 15.hours
            @t1 = DateTime.now.in_time_zone("Hanoi")
            @t2 = @product.end_time.in_time_zone("Hanoi") 
          else
            @time = DateTime.now.in_time_zone("Hanoi") - 15.hours + @product.hours_to_bid.hours
            @t1 = DateTime.now.in_time_zone("Hanoi")
            @t2 = DateTime.now.in_time_zone("Hanoi")
          end


          bids = BidHistory.where(product_id: params[:id])
          bidautos = BidAuto.where(product_id: params[:id])
    
          bidders = Array.new 
          bidders2 = Array.new 
          bids.each do |b| 
                bidders.push(b.user_id)
  
          end
          bidautos.each do |b| 
                bidders2.push(b.user_id)
  
          end
          bidders = bidders|bidders2
          @bidderss = bidders.count
          if (@product.max_price > @product.starting_price) 
            @hBidder = User.find_by(id:  @product.winner)

          end
          
          @canEdit=false;
          @canEnd=false;
          if (@cur_user)
            @isLogin=true;
            @canEdit=true;
            @canEnd=true;
            if (@cur_user.id != @seller.id)
              @check=true
              @canEdit=false;
              @canEnd=false;
            end
          end
          @check2=false

          if (@t1 > @t2 && @product.status=="Bidding") 
            @check=false         
            if (@product.winner)
                @product.can_edit = false
                if (@product.status == "Bidding")
                  @product.status="Ended"
                  m = Message.find_by(user_id: @product.winner, product_id: params[:id])
                  if (m)
                    m.content = "You win!!"
                    m.typee = "win"
                    m.save
                  else
                    m=Message.new(user_id:  @product.winner, product_id: params[:id], typee: "win")
                    m.content = "You win!!"
                    m.save
                  end
          
                  bids = BidHistory.where(product_id: params[:id])
                  bidautos = BidAuto.where(product_id: params[:id])
                  bids.each do |b| 
                        if (b.user_id!=@product.winner)
                          m = Message.find_by(user_id: b.user_id, product_id: params[:id])
                          if (m)
                            m.content = "You lose!!"
                            m.typee = "lose"
                            m.save
                          else
                            m=Message.new(user_id: b.user_id, product_id: params[:id], typee: "lose")
                            m.content = "You lose!!"
                            m.save
                          end
                        end
                  end
                  bidautos.each do |b| 
                        if (b.user_id!=@product.winner)
                          m = Message.find_by(user_id: b.user_id, product_id: params[:id])
                          if (m)
                            m.content = "You lose!!"
                            m.typee = "lose"
                            m.save
                          else
                            m=Message.new(user_id: b.user_id, product_id: params[:id], typee: "lose")
                            m.content = "You lose!!"
                            m.save
                          end
                        end
                  end
                end
            else
              @product.can_edit = true
              @product.hours_to_bid=0;
              @product.status="Time out"
            end
            @product.save
          end

          if (@product.status == "Cancelled" || @product.status == "Waitting" || @product.status == "Declined")
            @canEnd=false;
            @product.can_edit = true;
            @product.save
          end

          if (@product.status == "Ended")
            @check=false;
            @check2=true;
            @winner = User.find_by(id: @product.winner)
          end
  
          @canBuy=false;
          if (@product.buy_now_price > @product.current_price + @product.rising_price )
            @canBuy=true;
          end
          if (@t1 > @t2) 
            @canBuy=false;
          end
          @cart = true;
          if (@cur_user) 
            if (@cur_user.id == @seller.id) 
              @canBuy=false;
              @cart = false;
            end
          end
          @isFavorite = false;
          if (Favorite.exists?(user_id: session[:current_user_id], product_id: params[:id]))
            @isFavorite = true;
          end
          @staff = false;
          @favorite = true;
          if (@cur_user)
            if (@cur_user.typee == "staff")
                @canBuy = false
                @canEdit= false
                @canEnd=false
                @check = false;
                @cart = false;
                @favorite = false;
                @staff = true
            end

            if (@product.status == "Waitting" && @cur_user.typee == "staff")
              @staff = true
            else            
              @staff = false        
            end
          else
            @canBuy = false
            @canEdit= false
            @canEnd=false
            @check = false;
            @favorite = false;
          end
            
        else
          redirect_to products_path
        end
      
    end
    
      def like
        if (!Favorite.exists?(user_id: session[:current_user_id], product_id: params[:id]))        
          f=Favorite.new(user_id: session[:current_user_id], product_id: params[:id])
          f.save
        end
        redirect_to product_path(params[:id])
      end

      def dislike
        
        if (Favorite.exists?(user_id: session[:current_user_id], product_id: params[:id])) 
          f = Favorite.find_by(user_id: session[:current_user_id], product_id: params[:id])        
          f.destroy
        end
        redirect_to product_path(params[:id])
      end

      def accept
        @product.status="Bidding"
        @product.accepted_time = DateTime.now.in_time_zone("Hanoi")
        @product.accepter_id = session[:current_user_id]
        @product.end_time = DateTime.now.in_time_zone("Hanoi") + @product.hours_to_bid.hours 
        @product.save
        m = Message.find_by(user_id: @product.seller_id, product_id: params[:id])
        if (m)
          m.content = "Your product had been accepted!!"
          m.typee = "accept"
          m.save
        else
          m=Message.new(user_id: @product.seller_id, product_id: params[:id], typee: "accept")
          m.content = "Your product had been accepted!!"
          m.save
        end
        redirect_to staff_path
      end

      def decline
        @product.status="Declined"
        @product.accepted_time = DateTime.now.in_time_zone("Hanoi")
        @product.accepter_id = session[:current_user_id]
        @product.reason = params[:post][:reason]
        @product.save
        m = Message.find_by(user_id: @product.seller_id, product_id: params[:id])
        if (m)
          m.content = "Your product had been declined!! (" + params[:post][:reason] + ")"
          m.typee = "decline"
          m.save
        else
          m=Message.new(user_id: @product.seller_id, product_id: params[:id], typee: "decline")
          m.content = "Your product had been declined!! (Reason: " + params[:post][:reason] + "). Let's edit your product!" 
          m.save
        end
        redirect_to staff_path
      end

      # GET /products/new
      def new
        @categories = Category.all
        @product = Product.new
      end
    
      # GET /products/1/edit
      def edit
        if (@product.can_edit == false) 
          redirect_to product_path(params[:id])
        end
      end

      def end
          @product.status="Cancelled"
          @product.can_edit=true
          @product.current_price=@product.starting_price
          @product.max_price=@product.starting_price
          @product.hours_to_bid=0
          @product.winner=nil
          @product.end_time = DateTime.now.in_time_zone("Hanoi") 
          @product.save
          messages = Message.where(product_id: params[:id])
          messages.each do |m| 
              m.typee = "cancelled"
              m.content= "This bidding had been cancelled!!"
              m.save
          end
          BidAuto.where(product_id: params[:id]).destroy_all
          BidHistory.where(product_id: params[:id]).destroy_all
          redirect_to product_path(params[:id])
      end
    
      # POST /products
      # POST /products.json
      def create
        @product = Product.new(product_params)
        @product.status="Waitting"
        @product.seller_id=session[:current_user_id]
        @product.can_edit=true
        @product.current_price=@product.starting_price
        @product.max_price=@product.starting_price
        @product.end_time = DateTime.now.in_time_zone("Hanoi") 
        respond_to do |format|
          if @product.save
            format.html { redirect_to @product, notice: 'Product was successfully created.' }
            format.json { render :show, status: :created, location: @product }
          else
            format.html { render :new }
            format.json { render json: @product.errors, status: :unprocessable_entity }
          end
        end
      end
    
      # PATCH/PUT /products/1
      # PATCH/PUT /products/1.json
      def update
        @product.end_time = @product.end_time.in_time_zone("Hanoi") 
        respond_to do |format|
          if @product.update(product_params)
              @product.end_time = DateTime.now.in_time_zone("Hanoi")
              if (@product.status=="Declined" || @product.status=="Time out")
                @product.status="Waitting"
              end
              @product.save
            format.html { redirect_to @product, notice: 'Product was successfully updated.' }
            format.json { render :show, status: :ok, location: @product }
          else
            format.html { render :edit }
            format.json { render json: @product.errors, status: :unprocessable_entity }
          end
        end
      end
    
      # DELETE /products/1
      # DELETE /products/1.json
      def destroy
        if (@product.current_price==@product.starting_price)
          BidAuto.where(product_id: params[:id]).destroy_all
          BidHistory.where(product_id: params[:id]).destroy_all
          Message.where(product_id: params[:id]).destroy_all
          Favorite.where(product_id: params[:id]).destroy_all
          @product.destroy
          respond_to do |format|
            format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
            format.json { head :no_content }
          end
        else
          redirect_to product_path(params[:id])
        end
      end
      # Set authenticate to access routes
      
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_product
          @product = Product.find(params[:id])
        end
    
        # Never trust parameters from the scary internet, only allow the white list through.
        def product_params
          params.require(:product).permit(:name, :description, :category, :buy_now_price, :starting_price, :rising_price, :hours_to_bid, :image, :remove_image)
        end


        def check_seller
          @seller = User.find_by(id: @product.seller_id)
          @cur_user = User.find_by(id: session[:current_user_id])
          if (@cur_user.id != @seller.id)
            redirect_to product_path(@product.id)
          end
      end

      def check_block
        cur_user = User.find_by(id: session[:current_user_id])
        if (cur_user)
          if (cur_user.status == "blocked")
              redirect_to profile_path(cur_user.id)
          end
        end
      end
end
