<%= simple_form_for(offer, url: customer_offers(offer), method: "patch") do |f| %>
  <%= f.button :submit, "create", class:["btn-sm", "btn-w-m btn-primary"] %>
<%end%>
