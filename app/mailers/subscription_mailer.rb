# frozen_string_literal: true

class SubscriptionMailer < ApplicationMailer
  include InvoicesHelper

  def payment_failed(invoice)
    @invoice = invoice
    @user    = invoice.user
    @site    = invoice.site

    mail(:to => @user.email)
  end

  def payment_succeeded(invoice)
    @invoice = invoice
    @user    = invoice.user
    @site    = invoice.site

    pdf = InvoiceAsPdf.new invoice
    attachments["Drumknott-#{invoice_number invoice}.pdf"] = pdf.render

    mail(:to => @user.email)
  end
end
