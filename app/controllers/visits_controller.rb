class VisitsController < ApplicationController

  expose(:all_visits) { Visit.ordered.decorate }
  expose(:visits)
  expose_decorated(:visit, attributes: :permitted_params)
  expose(:meds) { Med.search(params[:search]).limit(15) }
  expose(:recognitions) { Recognition.limit(15) }

  before_filter :authenticate_stuff!, only: :index
  before_filter :visit_patient_and_doctor, only: :show
  before_filter :authenticate_patient!, only: :request

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

  def update_meds
    @searched_meds = (visit.meds.ordered.entries + Med.ordered.search(params[:search]).entries).uniq
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def prescript
    visit.save
    render :index
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
