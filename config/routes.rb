Rails.application.routes.draw do
  resources :bill_movement, only: %i[index]
end
