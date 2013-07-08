class CreateCommutes < ActiveRecord::Migration
  def change
    create_table :commutes do |t|
      t.string :name
      t.string :start
      t.string :end
      t.datetime :start_time
      t.datetime :end_time
      t.integer :user_id

      t.timestamps
    end
  end
end
