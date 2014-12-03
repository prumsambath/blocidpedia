class CheckoutsController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "Blocidpedia Premium - #{current_user.name}",
      amount: Amount.default
    }
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Blocidpedia Premium - #{current_user.email}",
      currency: 'usd'
    )

    if current_user.update_attribute(:role, "premium")
      flash[:notice] = "Your account has been upgraded to premium."
    else
      flash[:error] = "Error while upgrading your account."
    end
    redirect_to edit_user_registration_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
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
