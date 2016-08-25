ActiveAdmin.register SurveyQuestion do
  permit_params :name, :data_type, :selection_type, :instructions, :position
  config.sort_order = 'position_asc'
  config.paginate = false
  sortable
  index do
    sortable_handle_column
    id_column
    column :position
    column :survey_group
    column :name
    column :data_type
    column :selection_type
    column :instructions
    actions
  end
end
