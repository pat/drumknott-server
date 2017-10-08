# frozen_string_literal: true

class InvoiceAsPdf < Prawn::Document
  def initialize(invoice)
    @invoice = invoice

    super()

    build_content
  end

  private

  attr_reader :invoice

  def build_content
    InvoicePdf::Metadata.call invoice, self

    InvoicePdf::Header.call invoice, self
    move_down 10
    InvoicePdf::Body.call invoice, self
    move_down 10
    InvoicePdf::Footer.call invoice, self
  end
end
