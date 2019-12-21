module Customer::BoxesHelper

  def addBoxLinks(box:, subscriber:)
    #if subscribed is true or false, then we're dealing with foreign boxes
    if subscriber == nil
      render partial: "customer_box_links", locals: {box: box}
    else
      subscribed = subscriber.subscribed?(box)
      render partial: "foreign_box_links", locals: {subscriber: subscriber, box: box, subscribed: subscribed}
    end
  end

  def createWelcomeMessage(box_count:, foreign_box:)
    case foreign_box
    when true
      render partial: 'foreign_box_index_title'
    when false
      if box_count == 0
        render partial: 'customer_welcome_message'
      else
        render partial: 'customer_welcome_back_message', locals: {box_count: box_count}
      end
    end
  end

end
