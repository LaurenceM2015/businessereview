class Restaurant < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  searchkick
  
  has_many :reviews
  
  validates :name, :address, :phone, :website, :image, presence: true
   
   #check the phone number formating
  validates :phone, format: { with: /\A\(\d{3}\) \d{3}-\d{4}\z/,
    message: "must be in the format (123) 456-7890" }
    
    #check the website formating
    validates :website, format: { with: /\Ahttps?:\/\/.*\z/,
      message: "must start with http:// or https://" }
      
     #check the Address formating
    validates :address, format: { with: /\A\d+[^,]+,[^,]+, [A-Z]{2} \d{5}\z/,
      message: "must be in the format 350 Fifth Avenue, New York, NY 10118" }
end
