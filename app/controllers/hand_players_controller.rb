class HandPlayersController < ApplicationController
  def create
    hand = Hand.find(params[:hand_player][:hand_id])
    @hand_player = HandPlayer.create(hand_player_params)
    redirect_to :controller => 'games', :action => 'add_players', :id => hand.game.id
  end

  def update
    @hand_player = HandPlayer.find(params[:id])
    @hand_player.update(hand_player_params)
    redirect_to :controller => 'games', :action => 'score', :id => @hand_player.hand.game.id
  end

  private
    def hand_player_params
      params.require(:hand_player).permit(:hand_id, :game_player_id, :bid, :tricks, :position)
    end
end
