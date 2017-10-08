# frozen_string_literal: true

class InvoicePdf::Footer < InvoicePdf::Base
  def call
    text "#{ENV["INVOICE_REFERENCE_LABEL"]}: #{ENV["INVOICE_REFERENCE"]}"
    text "All dollar values listed are in #{invoice.data["currency"].upcase}."
    if invoice.user.country == "AU"
      text "Total amount listed includes 10% GST for Australian customers."
    end
    text "For questions, support and feedback, please email " \
      "<link href=\"mailto:hello@drumknottsearch.com\">" \
      "hello@drumknottsearch.com</link>.",
      :inline_format => true
  end

  private

  delegate :text, :to => :document
end
