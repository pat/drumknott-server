class My::InvoicesController < My::ApplicationController
  expose(:section)  { 'invoices' }
  expose(:invoices) { current_user.invoices }
  expose(:invoice)  { invoices.find params[:id] }

  def show
    respond_to do |format|
      format.html
      format.pdf do
        send_data pdf.render, filename: "invoice_#{invoice.id}.pdf"
      end
    end
  end

  private

  def pdf
    InvoiceAsPdf.new invoice
  end
end
