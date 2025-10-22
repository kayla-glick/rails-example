class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all

    render Invoices::Index.new(invoices: @invoices)
  end

  def create
    invoice = Invoice.create(status: :pending)
    ::GenerateInvoicePDFJob.perform_async(invoice.id)

    render turbo_stream: turbo_stream.replace(
      Invoices::Index::DOM_ID,
      Invoices::Show.new(invoice:)
    )
  end
end
