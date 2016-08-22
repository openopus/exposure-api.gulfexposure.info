class SurveyGroup < ApplicationRecord
  has_many :questions, class_name: SurveyQuestion

  def as_json(options={})
    res = super(options)
    res[:questions] = self.questions.as_json(options) if (options[:deep])
    res
  end
end
