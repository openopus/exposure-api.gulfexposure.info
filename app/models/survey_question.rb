class SurveyQuestion < ApplicationRecord
  belongs_to :survey_group
  has_many :options, class_name: QuestionOption

  def as_json(opts={})
    res = super(opts)
    res[:options] = self.options.as_json(opts)
    res[:data_type_class] = self.data_type.downcase.gsub(/ /, "-")
    res[:seltype] = self.selection_type.downcase.gsub(/ /, "-")
    res
  end
end
