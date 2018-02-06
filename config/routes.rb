Rails.application.routes.draw do
  get 'home/index'

  resources :players, :games, :game_players

  get 'games/:id/add_players', to: 'games#add_players'

  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
