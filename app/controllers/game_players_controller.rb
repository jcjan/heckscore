class GamePlayersController < ApplicationController
  def create
    game = Game.find(params[:game_player][:game_id])
    @game_player = game.game_players.create(game_player_params)
    if game.next_position
      redirect_to :controller => 'games', :action => 'add_players', :id => game.id
    else
      redirect_to :controller => 'games', :action => 'score', :id => game.id
    end
  end

  private
    def game_player_params
      params.require(:game_player).permit(:player_id, :game_id, :position)
    end
end
