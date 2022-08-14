class Apod < ActiveRecord::Base
  has_many :user_apods
  has_many :users, through: :user_apods
end