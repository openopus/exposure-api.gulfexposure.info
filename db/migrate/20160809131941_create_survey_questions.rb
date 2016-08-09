class CreateSurveyQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :survey_questions do |t|
      t.string :text
      t.string :type
      t.string :choices, limit: 2048

      t.timestamps
    end
  end
end
