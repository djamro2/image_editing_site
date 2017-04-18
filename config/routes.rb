Rails.application.routes.draw do
  get 'home/index'
  get 'gif_reverser', to: 'gif_reverser#index'
  match '/gif_reverser' => 'gif_reverser#reverse_gif', via: :post
  get 'gif_reverser/index'
  root 'home#index'
end
