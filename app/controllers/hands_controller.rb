class HandsController < ApplicationController
  def update
    @hand = Hand.find(params[:id])
    if @hand.update_attributes(hand_params)
      # Handle a successful update.
    else
      render 'edit'
    end
  end

  private

    def hand_params
      params.require(:hand).permit(:dealer_id)
    end
end
