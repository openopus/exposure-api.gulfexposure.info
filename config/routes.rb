Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount GenericApiRails::Engine => '/api'
  root "admin/dashboard#index"
end
