Rails.application.routes.draw do
  get 'home/index'

  resources :players, :games, :hands, :game_players, :hand_players

  get 'games/:id/add_players', to: 'games#add_players'
  get 'games/:id/score', to: 'games#score'

  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
