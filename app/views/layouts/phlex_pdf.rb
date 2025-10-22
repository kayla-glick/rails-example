class PhlexPdf < ApplicationView
  include Phlex::Rails::Layout
  include Propshaft::Helper

  def view_template
    doctype

    html do
      head do
        meta(charset: "utf-8")
        meta(name: "viewport", content: "width=device-width, initial-scale=1")
        link(rel: "stylesheet", href: "https://fonts.googleapis.com/css2?family=Inter:wght@100..900")
        yield(:head) if helpers.content_for?(:head)
      end
      body(class: "font-sans") do
        yield
      end
    end
  end

  private

  def root_path
    @_root_path ||= (String === Rails.root) ? Pathname.new(Rails.root) : Rails.root
  end

  def add_extension(filename, extension)
    filename.to_s.split(".").include?(extension) ? filename : "#{filename}.#{extension}"
  end
end
