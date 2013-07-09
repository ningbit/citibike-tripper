class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, :null => false, :default => ""
      t.string :twitter
      t.string :cell_number
      t.string :home_station
      t.string :work_station

      t.timestamps
    end
  end
end
