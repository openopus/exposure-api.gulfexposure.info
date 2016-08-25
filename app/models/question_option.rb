class QuestionOption < ApplicationRecord
  belongs_to :survey_question
  acts_as_list scope: :survey_question
end
