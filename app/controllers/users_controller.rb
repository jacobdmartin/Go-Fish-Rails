class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    User.create(name: params[:user][:name], password: params[:user][:password])
    redirect_to '/games'
  end
end
