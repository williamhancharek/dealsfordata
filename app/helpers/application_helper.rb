module ApplicationHelper

  def sidebar(active:, box:, logged_in: )
#locals: {box: @box, active: "settings"}

  end

  def tabsorter(active:, box: )
    if user_signed_in?
      render partial: "partials/tabs_index", locals: {active: active, box: box}
    else
    render partial: "partials/tabs_logged_out", locals: {active: active}
    end
  end

  def horizontaltabsorter(active:, box: )
    if user_signed_in?
      render partial: "partials/tabs_index_horizontal", locals: {active: active, box: box}
    else
      render partial: "partials/tabs_logged_out_horizontal", locals: {active: active}
    end
  end

end
