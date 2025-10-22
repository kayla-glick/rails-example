class Invoices::CreatePdf < ApplicationService
  def initialize(invoice:)
    @invoice = invoice
  end

  def call
    WickedPdf.new.pdf_from_string(
      ApplicationController.renderer.render_to_string(
        Invoices::Pdf.new(invoice: @invoice),
        layout: proc { PhlexPdf }
      ),
      {
        page_size: "Letter",
        disable_smart_shrinking: true
      }
    )
  end
end
