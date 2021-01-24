class Api::V1::OrdersController < ApplicationController
  before_action :find_school
  before_action :find_order, only: %i[update destroy]
  
  def index
    render json: @school.orders
  end
  
  def create
    # TODO: Validate recipients exists in database
    # TODO: Status by default Processing
    order = @school.orders.build(order_params)
    if order.save
      render json: order, status: :created
    else
      render json: { errors: order.errors }, status: :unprocessable_entity
    end
  end
  
  def update
    # TODO: Validate recipients exists in database
    if @order.update(order_params)
      render json: @order
    else
      render json: { errors: @order.errors }, status: :unprocessable_entity
    end
  end
  
  def destroy
    # TODO: Skip validations in model
    if @order.update(cancelled_at: Time.zone.now, status: :cancelled)
      head :ok 
    else
      render json: { errors: @order.errors }, status: :unprocessable_entity
    end
  end

  private 

  def order_params
    params.require(:order).permit(:status, gifts: [], recipient_ids: [])
  end

  def find_school
    @school = School.find_by(id: params[:school_id])
    return render json: { error: "School not found" }, status: :not_found unless @school
  end

  def find_order
    @order = @school.orders.find_by(id: params[:id])
    render json: { error: "order not found" }, status: :not_found unless @order
  end
end