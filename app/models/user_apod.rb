class UserApod < ActiveRecord::Base
  belongs_to :user
  belongs_to :apod
end