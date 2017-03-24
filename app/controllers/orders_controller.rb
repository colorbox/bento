class OrdersController < ApplicationController
  def index
    @today_order = Order.find_by(date: Time.current)
    @orders = Order.available
  end
end
