class HomeController < ApplicationController
  def index
    @products = Product.where.not(status: "Waitting")
    @products = @products.find_all { |pro| pro.status != "Declined"}
    #@time = @product.created_at.utc.to_datetime - 8.hours + @product.hours_to_bid.hours
  end
end
