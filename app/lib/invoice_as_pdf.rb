class InvoiceAsPdf < Prawn::Document
  include ActionView::Helpers::NumberHelper
  include InvoicesHelper

  FROM_ADDRESS = <<-TEXT
Invoice From:
#{ENV['INVOICE_FROM']}
  TEXT

  def initialize(invoice)
    @invoice = invoice

    super()

    build_content
  end

  private

  attr_reader :invoice

  def build_content
    set_fonts

    create_header
    move_down 10
    create_body
    move_down 10
    text "#{ENV['INVOICE_REFERENCE_LABEL']}: #{ENV['INVOICE_REFERENCE']}"
    text "All dollar values listed are in #{invoice.data['currency'].upcase}."
    if invoice.user.country == 'AU'
      text "Total amount listed includes 10% GST for Australian customers."
    end
    text "For questions, support and feedback, please email <link href=\"mailto:hello@drumknottsearch.com\">hello@drumknottsearch.com</link>.",
      :inline_format => true
  end

  def set_fonts
    font_families.update(
      'Museo Slab' => {:normal => font_path('museoslab_700-webfont.ttf')}
    )
    font_families.update(
      'Museo Sans' => {
        :normal => font_path('museosans_300-webfont.ttf'),
        :bold   => font_path('museosans_500-webfont.ttf')
      }
    )

    font 'Museo Sans', size: 10
    default_leading 5
  end

  def create_header
    table(
      [
        ['Drumknott', metadata],
        [FROM_ADDRESS, '']
      ], width: bounds.width
    ) do
      cells.border_width = 0.0

      columns(1).align = :right

      column(0).row(0).font = 'Museo Slab'
      column(0).row(0).size = 40
    end
  end

  def font_path(file_name)
    Rails.root.join 'app', 'assets', 'fonts', file_name
  end

  def metadata
    <<-TEXT
Invoice #: #{ invoice_number invoice }
Created: #{ invoice.invoiced_at.to_formatted_s :date_only }
For #{ invoice.user.email }
Status: #{ invoice.data['paid'] ? 'Paid' : 'Due' }
    TEXT
  end

  def create_body
    summary_rows = (items.length + 1)..-1

    table body_items, width: bounds.width do
      cells.padding       = 8
      cells.borders       = [:bottom]
      cells.border_width  = 0.2
      cells.border_color  = 'cccccc'
      cells.align         = :right

      columns(0).align    = :left
      columns(0).width    = 280

      rows(summary_rows).borders = []

      row(0).border_width = 0.5
      row(0).font_style   = :bold
      row(0).border_color = '000000'

      row(-1).borders      = [:top]
      row(-1).border_width  = 0.5
      row(-1).font_style   = :bold
      row(-1).border_color = '000000'
    end
  end

  def items
    invoice.data['lines']['data']
  end

  def body_items
    [
      ['Item', 'Amount']
    ] + items.collect { |line|
      [
        "Monthly subscription for #{ invoice.site.name }",
        to_currency(line['amount'])
      ]
    } + totals
  end

  def totals
    data = [
      ['', "Subtotal: #{ to_currency invoice.data['subtotal'] }"],
      ['', "Total: #{ to_currency invoice.data['total'] }"]
    ]

    if invoice.data['discount'].to_i > 0
      data.insert 1, ['', "Discount: #{ to_currency invoice.data['discount'] }"]
    end

    data
  end

  def to_currency(number)
    number_to_currency(number.to_i / 100.0)
  end
end
