class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
         #This dependent: :destroy just means that if a User is deleted, 
         #all of the Reviews written by that User should be deleted as well           
         
         has_many :reviews, dependent: :destroy
         
         validates :first_name, :last_name, presence: true
end
