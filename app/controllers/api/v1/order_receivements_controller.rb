class Api::V1::OrderReceivementsController < ApplicationController
  include Orderable

  before_action :find_order

  def create
    return render json: { error: "can't transition to receive" }, status: :unprocessable_entity unless @order.shipped?

    if @order.update(received_at: Time.zone.now, status: :received)
      render json: @order
    else
      render json: { errors: @order.errors }, status: :unprocessable_entity
    end
  end
end
