class CreateApods < ActiveRecord::Migration[6.1]
  def change
    create_table :apods do |t|
      t.string :date
      t.string :explanation
      t.string :hdurl
      t.string :media_type
      t.string :service_version
      t.string :title
      t.string :url
    end
  end
end
