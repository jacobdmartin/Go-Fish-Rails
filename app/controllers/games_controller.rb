class GamesController < ApplicationController

  def index
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      @game
      flash[:success] = "Game Successfully Created"
      redirect_to games_url
    else
      flash[:danger] = "Game Not Created"
      render :new
    end
  end

  def show
    render :show
  end

  def watch
    render :watch
  end

  private 

  def game_params
    params.require(:game).permit(:name)
  end
end