ActiveAdmin.register SurveyGroup do
  permit_params :name, :instructions, :position
  config.sort_order = 'position_asc'
  config.paginate = false
  sortable
  index do
    sortable_handle_column
    id_column
    column :position
    column :name
    column :instructions
    actions
  end
end
