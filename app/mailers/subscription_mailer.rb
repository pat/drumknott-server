class SubscriptionMailer < ::ActionMailer::Base
  include InvoicesHelper

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

  def payment_succeeded(invoice)
    @invoice = invoice
    @user    = invoice.user
    @site    = invoice.site

    pdf = InvoiceAsPdf.new invoice
    attachments["Drumknott-#{invoice_number invoice}.pdf"] = pdf.render

    mail(
      :to      => @user.email,
      :subject => "Drumknott: Payment for your subscription succeeded"
    )
  end
end
