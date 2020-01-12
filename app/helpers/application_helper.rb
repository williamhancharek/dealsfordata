module ApplicationHelper

  def sidebar(active:, box:, logged_in: )
#locals: {box: @box, active: "settings"}

  end

  def tabsorter(active:, box: )
    if user_signed_in?
      if box.present?
        render partial: "partials/tabs_box", locals: {active: active, box: box}
      else
        render partial: "partials/tabs_index"
      end
    else
    render partial: "partials/tabs_logged_out" if !(user_signed_in?)
    end
  end

  def horizontaltabsorter(active:, box: )
    if user_signed_in?
      if box.present?
        render partial: "partials/tabs_box_horizontal", locals: {active: active, box: box}
      else
        render partial: "partials/tabs_index_horizontal"
      end
    else
      render partial: "partials/tabs_logged_out_horizontal" if !(user_signed_in?)
    end
  end

end
