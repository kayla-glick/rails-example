class Invoices::Show < ApplicationView
  include Phlex::Rails::Helpers::TurboStreamFrom

  def initialize(invoice:)
    @invoice = invoice
  end

  def view_template
    turbo_frame(id: Invoices::Index::DOM_ID) do
      if @invoice.success?
        a(href: rails_representation_url(@invoice.pdf), target: "_blank") { "Download" }
      else
        turbo_stream_from(@invoice)

        p { "Invoice Generating" }
      end
    end
  end
end
