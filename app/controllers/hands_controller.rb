class HandsController < ApplicationController
  def update
    @hand = Hand.find(params[:id])
    @hand.update_attributes(hand_params)
    redirect_to :controller => 'games', :action => 'score', :id => @hand.game.id
  end

  private

    def hand_params
      params.require(:hand).permit(:dealer_id)
    end
end
