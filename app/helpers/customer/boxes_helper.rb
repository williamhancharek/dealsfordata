module Customer::BoxesHelper

  def addBoxLinks(box:, subscriber:)
    #if subscribed is true or false, then we're dealing with foreign boxes
    if subscriber.subscribed?(box)   == nil
      render partial: "customer_box_links", locals: {box: box}
    else
      render partial: "foreign_box_links", locals: {subscriber: subscriber, box: box}
    end
  end

end
