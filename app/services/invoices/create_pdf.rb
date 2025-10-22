class TripItineraries::Invoices::CreatePDF < ApplicationService
  def initialize(invoice:)
    @invoice = invoice
  end

  def call
    
  end

  private

  def view
    Invoices::PDF.new(invoice: @invoice)
  end
end
