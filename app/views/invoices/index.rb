class Invoices::Index < ApplicationView
  DOM_ID = "invoices_index".freeze

  def initialize(invoices:)
    @invoices = invoices
  end

  def view_template
    turbo_frame(id: DOM_ID) do
      a(href: invoices_path, data: { turbo: "true", turbo_method: :post }) { "Create Invoice" }
    end
  end
end
