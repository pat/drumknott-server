# frozen_string_literal: true

class InvoicePdf::Header < InvoicePdf::Base
  include InvoicesHelper

  FROM_ADDRESS = <<~TEXT.freeze
    Invoice From:
    #{ENV.fetch("INVOICE_FROM", nil)}
  TEXT

  def call
    table(
      data, :width => bounds.width
    ) do |table|
      table.cells.border_width = 0.0

      table.columns(1).align = :right

      table.column(0).row(0).font = "Museo Slab"
      table.column(0).row(0).size = 40
    end
  end

  private

  delegate :table, :bounds, :to => :document

  def data
    [
      ["Drumknott", metadata],
      [FROM_ADDRESS, ""]
    ]
  end

  def metadata
    <<~TEXT
      Invoice #: #{invoice_number invoice}
      Created: #{invoice.invoiced_at.to_fs :date_only}
      For #{invoice.user.email}
      Status: #{invoice.data["paid"] ? "Paid" : "Due"}
    TEXT
  end
end
