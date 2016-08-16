class SurveyAnswer < ApplicationRecord
  belongs_to :survey_question
  belongs_to :user
end
