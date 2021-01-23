class Api::V1::SchoolsController < ApplicationController
  before_action :find_school, only: %i[show update destroy]

  def index
    school = School.all
    render json: school
  end

  def create
    school = School.new(school_params)

    if school.save
      render json: school, status: :created
    else
      render json: { errors: school.errors }, status: :unprocessable_entity
    end
  end

  def show
    render json: @school
  end

  def update
    if @school.update(school_params)
      render json: @school
    else
      render json: { errors: @school.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if @school.destroy
      head :ok
    else
      render json: { errors: @school.errors }, status: :unprocessable_entity
    end
  end

  private

  def school_params
    params.require(:school).permit(:name, :address)
  end

  def find_school
    @school = School.find_by(id: params[:id])
    render json: { error: "School not found" }, status: :not_found unless @school
  end
end
