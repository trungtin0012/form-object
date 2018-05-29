class UsersController < ApplicationController
  def new
    @signupForm = SignupForm.new
  end

  def create
    @signupForm = SignupForm.new()
    if @signupForm.submit?(user_params)
      session[:user_id] = @signupForm.user.id
      redirect_to @signupForm.user, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end

  def show
    @user = current_user
  end

private

  def user_params
    params.require(:signup_form).permit(:username, :email, :password)
  end
end
