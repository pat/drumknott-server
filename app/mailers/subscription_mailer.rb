class SubscriptionMailer < ::ActionMailer::Base
  default from: "Drumknott <hello@drumknottsearch.com>"

  def payment_failed(invoice)
    @invoice = invoice
    @user    = invoice.user
    @site    = invoice.user.sites.find_by(
      :stripe_subscription_id => invoice.data['lines']['data'].first['id']
    )

    mail(
      :to      => @user.email,
      :subject => "Drumknott: Payment for your subscription failed"
    )
  end
end
