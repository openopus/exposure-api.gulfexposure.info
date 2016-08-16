class CreateSurveyQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :survey_questions do |t|
      t.references :survey_group, foreign_key: true
      t.string :name, limit: 1024
      t.string :type
      t.string :selection_type
      t.string :instructions, limit: 1024
      t.integer :position

      t.timestamps
    end
  end
end
