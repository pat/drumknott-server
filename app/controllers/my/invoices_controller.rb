class My::InvoicesController < My::ApplicationController
  expose(:section)  { 'invoices' }
  expose(:invoices) { current_user.invoices.order_by_date.page(page) }
  expose(:invoice)  { current_user.invoices.find params[:id] }

  def show
    respond_to do |format|
      format.html
      format.pdf do
        send_data pdf.render, filename: "invoice_#{invoice.id}.pdf"
      end
    end
  end

  private

  def page
    params[:page] ? params[:page].to_i : 1
  end

  def pdf
    InvoiceAsPdf.new invoice
  end
end
