Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get   'api/survey_answers_for/:codename'                          => 'survey_answers#survey_answers_for'
  match 'api/answer_question_for/:codename/:question_id(/:value)'   => 'survey_answers#answer_question_for', via: [:get, :post]

  mount GenericApiRails::Engine => '/api'
  root "admin/dashboard#index"
end
