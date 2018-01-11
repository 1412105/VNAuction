class CheckoutController < ApplicationController
    require "rubygems"
    require "braintree"

    Braintree::Configuration.environment = :sandbox
    Braintree::Configuration.merchant_id = ENV["BT_MERCHANT_ID"]
    Braintree::Configuration.public_key = ENV["BT_PUBLIC_KEY"]
    Braintree::Configuration.private_key = ENV["BT_PRIVATE_KEY"]
    def show
      @product = Product.find_by_id(params[:id])
      @client_tokent = Braintree::ClientToken.generate
    end
    def checkout
     @product = Product.find_by_id(params[:id])
     nonce_from_the_client = params[:payment_method_nonce]
     result = Braintree::Transaction.sale(
        :amount => @product.buy_now_price,
        :payment_method_nonce =>  nonce_from_the_client,
        :options => {
          :submit_for_settlement => true
        }
      )
    end
end
