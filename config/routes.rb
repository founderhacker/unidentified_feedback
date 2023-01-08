Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#home'
  get 'thanks', to: 'pages#thanks'
  get 'payment_received', to: 'pages#payment_received'
  get 'feedback_in_queue', to: 'pages#feedback_in_queue'
  resources :feedbacks, only: [:show, :create]
end
