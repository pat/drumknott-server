# frozen_string_literal: true

class InvoicePdf::Base
  def self.call(invoice, document)
    new(invoice, document).call
  end

  def initialize(invoice, document)
    @invoice  = invoice
    @document = document
  end

  private

  attr_reader :invoice, :document
end
