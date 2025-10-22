class Invoices::Pdf < ApplicationView
  def initialize(invoice:)
    @invoice = invoice
  end

  def view_template
    p { "Hello, world!" }
  end
end
