module ApplicationHelper

  def sidebar(active:, box:, logged_in: )
#locals: {box: @box, active: "settings"}

  end

  def tabsorter(active:, box: )
    if user_signed_in?
      if box.present?
        render partial: "partials/tabs", locals: {active: active, box: box}
      else
        render partial: "partials/tabs_index"
      end
    else
    render partial: "partials/logged_out_tab" if !(user_signed_in?)
    end
  end

  def horizontaltabsorter(active:, box: )
    if user_signed_in?
      if box.present?
        render partial: "partials/tabs_horizontal", locals: {active: active, box: box}
      else
        render partial: "partials/tabs_index_horizontal"
      end
    else
      render partial: "partials/logged_out_tab_horizontal" if !(user_signed_in?)
    end
  end

end
