Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get   'api/codename/regen/:codename'                              => 'codename#regen'
  get   'api/survey_template'                                       => 'survey#survey_template'
  post  'api/survey_submit'                                         => 'survey#survey_submit'
  get   'api/survey_answers_for/:codename'                          => 'survey#survey_answers_for'

  match 'api/answer_question_for/:codename/:question_id(/:value)'   => 'survey#answer_question_for', via: [:get, :post]
  match 'api/blog/create'                                           => 'blog#create',                via: [:get, :post]
  match 'api/blog/update'                                           => 'blog#update',                via: [:get, :post]

  mount GenericApiRails::Engine => '/api'
  root "admin/dashboard#index"
end
