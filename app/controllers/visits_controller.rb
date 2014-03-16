class VisitsController < ApplicationController

  expose(:visits)
  expose(:visit, attributes: :permitted_params)

  def create
    if visit.save
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if visit.save
      redirect_to visits_path
    else
      render :edit
    end
  end

  def destroy
    visit.destroy
    redirect_to visits_path
  end

  private

  def permitted_params
    params.require(:visit).permit(:patient_id, :speciality_id, :doctor_id, :confirmed, :date)
  end

end
