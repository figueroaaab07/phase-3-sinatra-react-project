class CreateUserApods < ActiveRecord::Migration[6.1]
  def change
    create_table :user_apods do |t|
      t.string :rating
      t.string :user_id
      t.string :apod_id
    end
  end
end
