class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def edit
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to action: "add_players", id: @game.id
    else
      render 'new'
    end
  end

  def update
    @game = Game.find(params[:id])

    if @game.update(game_params)
      redirect_to @game
    else
      render 'edit'
    end
  end

  def add_players
    @game = Game.find(params[:id])
  end

  def score
    @game = Game.includes(:players,
                          :hands,
                          :hands => :hand_players).find(params[:id])
  end

  private
    def game_params
      params.require(:game).permit(:date, :size, :first_dealer_id)
    end
end
