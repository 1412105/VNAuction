class Product < ApplicationRecord
    mount_uploader :image, ImageUploader
      has_many :bid_autos
      has_many :favorites
      has_many :messages
      has_many :bid_historys
      has_many :order_items
      validates_processing_of :image
      validate :image_size_validation
    
      private
      def image_size_validation
        errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
      end
      

end
