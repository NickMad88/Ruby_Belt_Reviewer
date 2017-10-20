class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by_email(login_helper[:email]).try(:authenticate, login_helper[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to events_path
    else
      flash[:errors] = ["Email and Password Combination not found!"]
      redirect_to '/sessions/new'
    end
  end

  def destroy
  end

  private
    def login_helper
      params.require(:login).permit(:email, :password) if params[:login].present?
    end
end
