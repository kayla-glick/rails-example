module RenderableRenderer
  def render(renderable, current_user: nil, &)
    renderable.render_in(view_context(current_user:), &)
  end

  def view_context(current_user:)
    controller = ApplicationController.new
    controller.set_request!(ActionDispatch::Request.empty)
    controller.define_singleton_method(:current_user) { current_user }
    controller.view_context
  end
end
