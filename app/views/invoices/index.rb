class Invoices::Index < ApplicationView
  DOM_ID = "invoices_index".freeze

  def initialize(invoices:)
    @invoices = invoices
  end

  def view_template
    turbo_frame(id: DOM_ID) do
      form_with(model: Invoice.new, url: invoices_path, method: :post) do |form|
        form.submit "Create Invoice"
      end
    end
  end
end
