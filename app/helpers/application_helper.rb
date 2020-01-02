module ApplicationHelper

  def navbar(active:, *passive:)
    render partial: "partials/crumb/active", locals: {active: active, passive: passive}
    passive.each do |t|
      render partial: "partials/crumb/passive", locals: {passive: t}
    end
  end
end
