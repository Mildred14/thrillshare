require "active_support/concern"

module Orderable
  extend ActiveSupport::Concern

  included do
    before_action :find_school
  end

  private
  
  def find_school
    @school = School.find_by(id: params[:school_id])
    return render json: { error: "School not found" }, status: :not_found unless @school
  end

  def find_order
    @order = @school.orders.find_by(id: params[:id])
    render json: { error: "order not found" }, status: :not_found unless @order
  end
end
