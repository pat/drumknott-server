# frozen_string_literal: true

class UserMailer < ActionMailer::Base
  default :from => "Drumknott <hello@drumknottsearch.com>"

  def deleted(email)
    mail(
      :to      => email,
      :subject => "Drumknott: Account Closed"
    )
  end
end
