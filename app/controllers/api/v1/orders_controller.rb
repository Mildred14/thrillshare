class Api::V1::OrdersController < ApplicationController
  include Orderable
  before_action :find_order, only: %i[update destroy]
  
  def index
    render json: @school.orders
  end
  
  def create
    order = @school.orders.build(order_params)
    if order.save
      render json: order, status: :created
    else
      render json: { errors: order.errors }, status: :unprocessable_entity
    end
  end
  
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: { errors: @order.errors }, status: :unprocessable_entity
    end
  end

  private 

  def order_params
    params.require(:order).permit(:notify_delivery, gifts: [], recipient_ids: [])
  end
end