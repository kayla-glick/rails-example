class Invoices::GeneratePdfJob
  include Sidekiq::Worker
  include RenderableRenderer

  sidekiq_options retry: false

  def perform(invoice_id)
    invoice = Invoice.find(invoice_id)

    pdf = PDF::TripItineraries::Create.call(itinerary: itinerary)

    invoice.pdf.attach(
      io: StringIO.new(pdf.payload),
      filename: "invoice-#{invoice.id}.pdf"
    )

    invoice.success!

    broadcast_replace_to(invoice)
  end

  private

  def broadcast_replace_to(invoice:)
    Turbo::StreamsChannel.broadcast_replace_to(
      invoice,
      target: "modal",
      html: html(invoice:)
    )
  end

  def html(invoice:)
    render Invoices::Show.new(invoice:)
  end
end
