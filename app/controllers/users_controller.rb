class UsersController < ApplicationController
  
  def create
    @user = User.new(reg_helper)
    if @user.save
      session[:user_id] = @user.id
      redirect_to events_path
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_sessions_path
    end
  end

  def edit
    puts params
  end

  def update
    puts params
    @user = User.find(current_user.id)
    @user.first_name = edit_helper[:first_name]
    @user.last_name = edit_helper[:last_name]
    @user.city = edit_helper[:city]
    @user.state = edit_helper[:state]
    @user.email = edit_helper[:email]
    if @user.save
        redirect_to events_path
    else
        flash[:errors] = @user.errors.full_messages
        redirect_to edit_user_path(current_user.id)
    end
  end

  private
    def reg_helper
      params.require(:reg).permit(:first_name, :last_name, :email, :city, :state, :password) if params[:reg].present?
    end

    def edit_helper
      puts params
      params.require(:up).permit(:first_name,:last_name,:email,:city,:state) if params[:up].present?
    end
    def check_user
      unless current_user.id.to_s == params[:id]
          redirect_to events_path
      end
    end
end
