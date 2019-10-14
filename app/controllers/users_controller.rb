class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(name: params[:user][:name], password: params[:user][:password])    # Not the final implementation!
    # @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to '/games' # Handle a successful save.
      # redirect_to @user
    else
      render 'new'
    end
  end

  private

    # def user_params
    #   params.require(:user).permit(:name, :email, :password,
    #                                :password_confirmation)
    # end
end
