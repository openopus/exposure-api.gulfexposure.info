class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :guid
      t.date :birthdate
      t.string :codename
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
