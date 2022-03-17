# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def deleted(email)
    mail(:to => email)
  end
end
