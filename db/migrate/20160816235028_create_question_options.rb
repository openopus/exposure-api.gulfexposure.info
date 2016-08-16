class CreateQuestionOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :question_options do |t|
      t.references :survey_question, foreign_key: true
      t.string :name
      t.integer :position

      t.timestamps
    end
  end
end
