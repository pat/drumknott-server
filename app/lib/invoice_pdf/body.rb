# frozen_string_literal: true

class InvoicePdf::Body < InvoicePdf::Base
  include ActionView::Helpers::NumberHelper

  def call
    table body_items, :width => bounds.width do |table|
      style_cells_in table
      style_columns_in table
      style_rows_in table
    end
  end

  private

  delegate :table, :bounds, :to => :document

  def body_items
    [
      %w[ Item Amount ]
    ] + item_lines + totals
  end

  def default_totals
    [
      ["", "Subtotal: #{to_currency invoice.data["subtotal"]}"],
      ["", "Total: #{to_currency invoice.data["total"]}"]
    ]
  end

  def items
    invoice.data["lines"]["data"]
  end

  def item_lines
    items.collect do |line|
      [
        "Monthly subscription for #{invoice.site.name}",
        to_currency(line["amount"])
      ]
    end
  end

  def style_cells_in(table)
    table.cells.padding       = 8
    table.cells.borders       = [:bottom]
    table.cells.border_width  = 0.2
    table.cells.border_color  = "cccccc"
    table.cells.align         = :right
  end

  def style_columns_in(table)
    table.columns(0).align    = :left
    table.columns(0).width    = 280
  end

  def style_first_row(row)
    row.border_width = 0.5
    row.font_style   = :bold
    row.border_color = "000000"
  end

  def style_last_row(row)
    row.borders      = [:top]
    row.border_width = 0.5
    row.font_style   = :bold
    row.border_color = "000000"
  end

  def style_rows_in(table)
    table.rows(summary_rows).borders = []

    style_first_row(table.row(0))
    style_last_row(table.row(-1))
  end

  def summary_rows
    (items.length + 1)..-1
  end

  def totals
    data = default_totals

    discount = invoice.data["subtotal"] - invoice.data["total"]
    if discount.positive?
      data.insert 1, ["", "Discount: #{to_currency discount}"]
    end

    data
  end

  def to_currency(number)
    number_to_currency(number.to_i / 100.0)
  end
end
