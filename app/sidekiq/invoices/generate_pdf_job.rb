class Invoices::GeneratePdfJob
  include Sidekiq::Worker
  include RenderableRenderer

  sidekiq_options retry: false

  def perform(invoice_id)
    invoice = Invoice.find(invoice_id)

    pdf = Invoices::CreatePdf.call(invoice:)

    invoice.pdf.attach(
      io: StringIO.new(pdf),
      filename: "invoice-#{invoice.id}.pdf"
    )

    invoice.success!

    broadcast_replace_to(invoice:)
  end

  private

  def broadcast_replace_to(invoice:)
    Turbo::StreamsChannel.broadcast_replace_to(
      invoice,
      target: Invoices::Index::DOM_ID,
      html: html(invoice:),
      layout: false
    )
  end

  def html(invoice:)
    render Invoices::Show.new(invoice:)
  end
end
