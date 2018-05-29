class PasswordsController < ApplicationController
  def new
    @passwordForm = PasswordForm.new(current_user)
  end

  def create
    @passwordForm = PasswordForm.new(current_user)
    if @passwordForm.submit?(password_params)
      redirect_to current_user, notice: "Successfully changed password."
    else
      render "new"
    end
  end

private

  def password_params
    params.require(:password_form).permit(:original_password, :new_password, :new_password_confirmation)
  end
end
