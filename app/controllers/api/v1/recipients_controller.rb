class Api::V1::RecipientsController < ApplicationController
  def index
    recipient = Recipient.all
    render json: recipient, status: :ok
  end
end
