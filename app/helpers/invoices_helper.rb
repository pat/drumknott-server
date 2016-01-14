module InvoicesHelper
  def invoice_number(invoice)
    invoice.id.to_s.rjust 6, '0'
  end

  def line_class_for(lines, line)
    lines.last == line ? 'item last' : 'item'
  end
end
