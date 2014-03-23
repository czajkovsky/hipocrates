class VisitsController < ApplicationController

  expose(:all_visits) { Visit.ordered.decorate }
  expose(:visits)
  expose_decorated(:visit, attributes: :permitted_params)

  before_filter :authenticate_stuff!, only: :index
  before_filter :visit_patient_and_doctor, except: :index

  def create
    if visit.save
      send_confirmation
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if visit.save
      send_confirmation
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    visit.destroy
    redirect_to root_path
  end

  private

  def permitted_params
    params.require(:visit).permit(:patient_id, :speciality_id, :doctor_id, :confirmed, :date, :reason, :note, :instructions, procedure_ids: [], recognition_ids: [], med_ids: [])
  end

  def send_confirmation
    PatientMailer.confirm_visit(visit).deliver if visit.patient.email.present? and visit.date.present?
  end

  def visit_patient_and_doctor
    redirect_to root_path unless visit.can_see?(current_user)
  end

end
