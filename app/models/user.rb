class User < ActiveRecord::Base
  has_many :user_apods
  has_many :apods, through: :user_apods
end