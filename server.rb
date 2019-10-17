# # require 'sinatra'
# # require 'sinatra/reloader'
# # require 'sprockets'
# # require 'sass'
# # require 'pry'
# require_relative 'app/models/go_fish'
# require_relative 'app/models/player'
# # require_relative 'sinatra-pusher'
# # require 'pusher'

# class Server
#   # < Sinatra::Base

#   # channels_client = Pusher::Client.new(
#   # app_id: '874073',
#   # key: '356a86fa22a4c249ad9a',
#   # secret: '5493e22b8a1f9abcc830',
#   # cluster: 'us2',
#   # encrypted: true
#   # )

#   # channels_client.trigger('my-channel', 'my-event', {
#   #   message: 'hello world'
#   # })

#   # configure :development do 
#   #   register Sinatra::Reloader
#   # end
  
#   # enable :sessions
#   # set :environment, Sprockets::Environment.new
#   # environment.append_path "assets/stylesheets"
#   # environment.append_path "assets/javascripts"
#   # environment.css_compressor = :scss

#   # get "/assets/*" do
#   #   env["PATH_INFO"].sub!("/assets", "")
#   #   settings.environment.call(env)
#   # end
  
#   def self.game
#     @@game ||= Game.new
#   end

#   def self.clear_game
#     @@game = nil
#   end

#   get '/' do
#     slim :start
#   end

#   get '/start/:name' do
#     player = Player.new('You')
#     cpu_count = (params[:name]).to_i
#     session[:current_player] = player.name
#     self.class.game.add_player(player)
#     self.class.game.create_cpu(cpu_count)
#     redirect '/game'
#   end

#   get '/game' do
#     redirect '/' if self.class.game.empty?
#     current_player = self.class.game.find_current_player(session[:current_player])
#     slim :game, locals: {game: self.class.game, current_player: current_player}
#   end

#   post '/ask' do
#     asking_player = self.class.game.find_current_player(session[:current_player])
#     requested_rank = params[:rank]
#     asked_player = self.class.game.find_current_player(params[:player])
#     self.class.game.take_turn(asking_player, asked_player, requested_rank)
#     redirect '/game'
#   end

#   post '/leave' do
#     redirect '/'
#   end

#   post '/new' do
#     redirect '/game'
#   end
# end