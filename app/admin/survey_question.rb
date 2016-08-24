ActiveAdmin.register SurveyQuestion do
  permit_params :name, :data_type, :selection_type, :instructions, :position
end
