ActiveAdmin.register SurveyGroup do
  permit_params: :name, :instructions, :position
end
