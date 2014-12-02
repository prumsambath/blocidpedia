class UsersController < ApplicationController
  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = 'User profile successfully updated.'
    else
      flash[:error] = 'Error while saving user profile.'
    end
    redirect_to edit_user_registration_path
  end

  def show
    @wikis = Wiki.own_wikis(current_user).page(params[:page]).per(10)
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
