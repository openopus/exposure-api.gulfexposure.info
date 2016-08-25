class SurveyQuestion < ApplicationRecord
  belongs_to :survey_group
  acts_as_list scope: :survey_group
  has_many :options, -> { order(position: :asc) }, class_name: QuestionOption, dependent: :destroy

  def as_json(opts={})
    res = super(opts)
    res[:options] = self.options.as_json(opts)
    res[:data_type_class] = self.data_type.downcase.gsub(/ /, "-")
    res[:seltype] = self.selection_type.downcase.gsub(/ /, "-")
    res
  end
end
