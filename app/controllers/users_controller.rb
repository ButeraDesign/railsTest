class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :require_correct_user, only: [:edit, :show, :update, :destroy]

  def index
  end

  def show
    puts 'In Show'
    @user = User.find(session[:user_id])
    #binding.pry
  end

  def create
    #POST from form, does the create
    puts 'In Create'
    #formParams = params[:user]
    binding.pry
    @user = User.new(user_params)
    binding.pry

    if @user.save
      #user created, have them logon now (or maybe log them in and go to show?)
      redirect_to "/sessions/new"
    else
      puts 'Create Error'
      flash[:errors] = @user.errors.full_messages
      # redirect_to :back
      redirect_to "/users/new"
    end
  end

  def new
    #shows form
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

    def require_correct_user
      if current_user != User.find(params[:id])
        redirect_to "/users/#{session[:user_id]}"
      end
    end


end
