class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def show
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new(game_params)
    player = Player.new(current_user.name)
    @game.go_fish = GoFish.new(@game.name, players: [player], player_num: game_params[:player_num])
    if @game.save
      game_user = GameUser.create(game: @game, user: current_user)
      flash[:success] = "Game Successfully Created"
      redirect_to game_path(@game)
    else
      flash[:danger] = "Game Not Created"
      render :new
    end
  end

  def join
    @game = Game.find(params[:id])
    player = Player.new(current_user.name)
    game_user = GameUser.create(game: @game, user: current_user)
    @game.go_fish.add_player(player)
    redirect_to game_path(@game)
  end

  def watch
    render :watch
  end

  private 

  def game_params
    params.require(:game).permit(:name, :player_num)
  end
end