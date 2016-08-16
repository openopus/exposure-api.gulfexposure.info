class SurveyGroup < ApplicationRecord
  has_many :questions, class_name: SurveyQuestion
end
