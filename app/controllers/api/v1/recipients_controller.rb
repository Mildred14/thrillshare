class Api::V1::RecipientsController < ApplicationController
  before_action :find_school
  before_action :find_recipient, only: %i[update destroy]

  def index
    render json: @school.recipients
  end
  
  def create
    recipient = @school.recipients.build(recipient_params)

    if recipient.save
      render json: recipient, status: :created
    else
      render json: { errors: recipient.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @recipient.update(recipient_params)
      render json: @recipient
    else
      render json: { errors: @recipient.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if @recipient.destroy
      head :ok 
    else
      render json: { errors: @recipient.errors }, status: :unprocessable_entity
    end
  end

  private

  def recipient_params
    params.require(:recipient).permit(:name, :address)
  end

  def find_school
    @school = School.find_by(id: params[:school_id])
    render json: { error: "School not found" }, status: :not_found unless @school
  end
  
  def find_recipient
    @recipient = @school.recipients.find_by(id: params[:id])
    render json: { error: "Recipient not found" }, status: :not_found unless @recipient
  end
end
