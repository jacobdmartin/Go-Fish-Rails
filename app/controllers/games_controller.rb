class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def show
    @game = Game.find(params[:id])
    @session_player = @game.go_fish.find_player_by_name(current_user.name)
  end

  def create
    @game = Game.new(game_params)
    player = Player.new(current_user.name)
    @game.go_fish = GoFish.new(@game.name, players: [player], player_num: game_params[:player_num])
    if @game.save
      @session_player = @game.go_fish.find_player_by_name(current_user.name)
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
    game_user = GameUser.create(game: @game, user: current_user)
    game_data = @game.go_fish
    player = Player.new(current_user.name)
    @session_player = @game.go_fish.find_player_by_name(current_user.name)
    game_data.add_player(player)
    @game.save
    redirect_to game_path(@game)
  end

  def update
    @game = Game.find(params[:id])
    @session_player = @game.go_fish.find_player_by_name(current_user.name)
    @card = turn_params[:hand]
    @player = @game.go_fish.find_player_by_name(turn_params[:players])
    @game.go_fish.take_turn(@session_player, @player, @card)
    redirect_to game_path(@game)
  end

  def watch
    render :watch
  end

  private 

  def game_params
    params.require(:game).permit(:name, :player_num)
  end

  def turn_params
    params.require(:game).permit(:hand, :players)
  end
end