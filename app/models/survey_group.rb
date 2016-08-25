class SurveyGroup < ApplicationRecord
  has_many :questions, -> {  order(position: :asc) }, class_name: SurveyQuestion
  acts_as_list

  def as_json(options={})
    res = super(options)
    res[:questions] = self.questions.as_json(options) if (options[:deep])
    res
  end
end
