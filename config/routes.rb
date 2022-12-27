Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#home'
  get 'pinned_tweet_thanks', to: 'pages#pinned_tweet_thanks'
  get 'skip_queue_thanks', to: 'pages#skip_queue_thanks'
  get 'pinned_tweet_payment_received', to: 'pages#pinned_tweet_payment_received'
  get 'skip_queue_payment_received', to: 'pages#skip_queue_payment_received'
  get 'feedback_in_queue', to: 'pages#feedback_in_queue'
  resources :feedbacks, only: [:show, :create]
end
