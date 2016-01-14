class My::InvoicesController < My::ApplicationController
  expose(:section)  { 'invoices' }
  expose(:invoices) { current_user.invoices }
  expose(:invoice)  { invoices.find params[:id] }
end
