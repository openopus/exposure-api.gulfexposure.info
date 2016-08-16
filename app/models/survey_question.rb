class SurveyQuestion < ApplicationRecord
  belongs_to :survey_group
  has_many :options, class_name: QuestionOption
end
