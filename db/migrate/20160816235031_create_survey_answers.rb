class CreateSurveyAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :survey_answers do |t|
      t.references :survey_question, foreign_key: true
      t.references :user, foreign_key: true
      t.text :value

      t.timestamps
    end
  end
end
