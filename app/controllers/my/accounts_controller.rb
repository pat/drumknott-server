class My::AccountsController < My::ApplicationController
  def update
    current_user.attributes = user_params
    email_changed = current_user.email_changed?

    if current_user.save
      UpdateCustomerWorker.perform_async current_user.id if email_changed

      redirect_to my_dashboard_path,
        :notice => "Your account details have been updated."
    else
      render 'edit'
    end
  end

  def change_card
    UpdateCardWorker.perform_async current_user.id, params[:stripeToken]

    redirect_to my_dashboard_path,
      :notice => "Your credit card is being updated."
  end

  private

  def user_params
    params.fetch(:user, {}).permit :email, :country
  end
end
