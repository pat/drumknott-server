# frozen_string_literal: true

class My::AccountsController < My::ApplicationController
  def update
    current_user.attributes = user_params

    if current_user.save
      redirect_to my_dashboard_path, :notice => t(".success")
    else
      render "edit"
    end
  end

  def destroy
    DeleteAccountWorker.perform_async current_user.id

    sign_out :user

    redirect_to root_path, :notice => t(".success")
  end

  def change_card
    UpdateCardWorker.perform_async current_user.id, params[:stripeToken]

    redirect_to my_dashboard_path, :notice => t(".success")
  end

  private

  def user_params
    params.fetch(:user, {}).permit :email, :country, :password,
      :password_confirmation
  end
end
