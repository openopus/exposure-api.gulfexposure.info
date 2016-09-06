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

    create_table :devices do |t|
      t.string :user_guid       # Key back to the ownng user(s)
      t.string :token           # From the codorva device plugin.
      t.string :os              # ios, android, windows, blackberry.
      t.string :ua              # What our browser says the User Agent is.
    end
  end
end
