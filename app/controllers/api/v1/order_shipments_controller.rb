class Api::V1::OrderShipmentsController < ApplicationController
  include Orderable

  before_action :find_order

  def create
    return render json: { error: "can't transition to shipped" }, status: :unprocessable_entity unless @order.processing?

    if @order.update(shipped_at: Time.zone.now, status: :shipped)
      # Send email if flag true OrderMailer.shipped(@order.id).deliver_later if @order.notify_deliver?
      render json: @order
    else
      render json: { errors: @order.errors }, status: :unprocessable_entity
    end
  end
end
