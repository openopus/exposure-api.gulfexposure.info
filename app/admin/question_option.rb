ActiveAdmin.register QuestionOption do
  permit_params :name, :position, :survey_question_id
end
