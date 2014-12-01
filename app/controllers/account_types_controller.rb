class AccountTypesController < ApplicationController
  def create
    if current_user.update_attribute(:role, "premium")
      flash[:notice] = "Your account has been upgraded to premium."
    else
      flash[:error] = "Error while upgrading your account."
    end
    redirect_to edit_user_registration_path
  end

  def destroy
    if current_user.update_attribute(:role, "standard")
      flash[:notice] = "Your account has been downgraded to standard."
    else
      flash[:error] = "Error while downgrading your account."
    end
    redirect_to edit_user_registration_path
  end
end