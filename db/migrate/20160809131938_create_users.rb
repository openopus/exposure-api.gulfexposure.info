class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :guid
      t.string :device_os               # ios, android, windows, blackberry
      t.string :device_uuid             # From the codorva device plugin
      t.string :user_agent              # What our browser says
      t.date :birthdate
      t.string :codename
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
