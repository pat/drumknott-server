class SubscriptionMailer < ::ActionMailer::Base
  default from: "Drumknott <hello@drumknottsearch.com>"

  def payment_failed(invoice)
    @invoice = invoice
    @user    = invoice.user
    @site    = invoice.site

    mail(
      :to      => @user.email,
      :subject => "Drumknott: Payment for your subscription failed"
    )
  end
end
