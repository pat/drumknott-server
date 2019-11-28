# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def deleted(email)
    mail(
      :to      => email,
      :subject => "Drumknott: Account Closed"
    )
  end
end
