class GamesController < ApplicationController

  def index
    @games = Game.all
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

  def join
    @game = Game.find(params[:id])
    player = Player.new(current_user.name)
    game_user = GameUser.new(game: @game, user: current_user)
    # @game.go_fish.add_player(player)
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