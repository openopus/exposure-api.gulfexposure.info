class CreateSurveyGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :survey_groups do |t|
      t.string :name
      t.string :instructions, limit: 2048
      t.integer :position

      t.timestamps
    end
  end
end
