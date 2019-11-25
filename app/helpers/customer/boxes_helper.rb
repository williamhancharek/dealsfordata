module Customer::BoxesHelper

  def addBoxLinks(box:, subscribed:)
    #if subscribed is true or false, then we're dealing with foreign boxes
    if subscribed == nil
      render partial: "customer_box_links", locals: {box: box}
    else
      render partial: "foreign_box_links", locals: {subscribed: subscribed, box: box}
    end
  end

end
