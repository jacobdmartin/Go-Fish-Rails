class GamesController < ApplicationController

  def index
  end

  def new
    @game = Game.new
  end

  def create
    @game_list = []
    @game_list << @game
  end
end