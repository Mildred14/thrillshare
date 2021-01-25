class Api::V1::OrderCancelsController < ApplicationController
    include Orderable
  
    before_action :find_order
  
    def create
      return render json: { error: "can't cancel" }, status: :unprocessable_entity unless @order.processing?
  
      if @order.update(cancelled_at: Time.zone.now, status: :cancelled)
        render json: @order
      else
        render json: { errors: @order.errors }, status: :unprocessable_entity
      end
    end
  end
