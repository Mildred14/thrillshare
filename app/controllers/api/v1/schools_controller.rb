class Api::V1::SchoolsController < ApplicationController
  def index
    school = School.all
    render json: school, status: :ok
  end

  def create
    school = School.new(school_params)

    if school.save
      render json: school, status: :created
    else
      render json: school.errors, status: :unprocessable_entity
    end
  end

  def show
    school = School.find(params[:id])
    byebug
    if school
      render json: school, status: :ok
    else
      render json: school, status: :unprocessable_entity
    end
  end

  def update
    school = School.find(params[:id])

    if school.update(school_params)
      render json: school, status: :ok
    else
      render json: school, status: :unprocessable_entity
    end
  end

  def destroy
    school = School.find(params[:id])
    if school.destroy
      render json: school, status: :ok
    else
      render json: school, status: :unprocessable_entity
    end
  end

  private

  def school_params
    params.require(:school).permit(:name, :address)
  end
end
