class UsersController < ApplicationController
 include Passwordless::ControllerHelpers # <-- This!
  # (unless you already have it in your ApplicationController)
  #helper_method :current_user
  #passwordless_with :email

  def index
    @users = User.all
  end
  

  #!Nasser: Trial and error
  # def new
  #   @user = User.new
  # end
  #!Nasser: From ChatGPT
  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(create_passwordless_session(@user)) # <-- This!
      redirect_to(@user, flash: { notice: "Welcome!" })
    else
      flash[:error] = @user.errors.full_messages
      render(:new)
    end
  end
  #? Nasser: from Cursor
  def about
  end
  
  def privacy_policy
    
  end
  def terms_of_service

  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
