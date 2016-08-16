class CreateSurveyAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :survey_answers do |t|
      t.string :text
      t.references :user, foreign_key: true
      t.references :survey_question

      t.timestamps
    end
  end
end
