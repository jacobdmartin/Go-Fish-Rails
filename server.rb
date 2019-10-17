
require 'sinatra'
require 'sinatra/reloader'
require 'sprockets'
require 'sass'

require_relative 'go_fish'
require_relative 'player'
require_relative 'sinatra-pusher'
require 'webdrivers'
require 'pusher'

class Server < Sinatra::Base

  configure :development do 
    register Sinatra::Reloader
    Pusher.app_id = 'go_fish'
    Pusher.key = ''
    Pusher.secret = ''
  end
  enable :sessions
  set :environment, Sprockets::Environment.new
  environment.append_path "assets/stylesheets"
  environment.append_path "assets/javascripts"
  environment.css_compressor = :scss
  get "/assets/*" do
    env["PATH_INFO"].sub!("/assets", "")
    settings.environment.call(env)
  end
  
  def self.game
    @@game ||= GoFish.new
  end

  def self.clear_game
    @@game = nil
  end

  get '/' do
    slim :log_in
  end

  post '/login' do
    player = Player.new(params[:name])
    session[:current_player] = player.name
    self.class.game.add_player(player)
    redirect '/game'
  end

  get '/game' do
    redirect '/' if self.class.game.empty?
    current_player = self.class.game.find_current_player(session[:current_player])
    slim :game, locals: {game: self.class.game, current_player: current_player}
  end

  post '/ask' do
    asking_player = self.class.game.find_current_player(session[:current_player])
    requested_rank = params[:rank]
    requested_player = self.class.game.find_current_player(params[:player])
    self.class.game.inquire_for_card(asking_player, requested_player, requested_rank)
    redirect '/game'
  end
end