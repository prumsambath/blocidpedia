class UsersController < ApplicationController
  def edit
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "Blocidpedia Premium - #{current_user.name}",
      amount: Amount.default
    }
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = 'User profile successfully updated.'
    else
      flash[:error] = 'Error while saving user profile.'
    end
    redirect_to edit_user_registration_path
  end

  def show
    @wikis = Wiki.own_wikis(current_user).page(params[:my_wikis]).per(10)
    @shared_wikis = Wiki.shared_to(current_user).page(params[:shared_wikis]).per(10)
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
