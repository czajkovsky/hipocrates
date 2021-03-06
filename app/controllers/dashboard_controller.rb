class DashboardController < ApplicationController

  expose(:patient_visits){ Visit.where(patient: current_user).ordered.decorate }
  expose(:pending_visits){ Visit.pending.decorate }
  expose(:confirmed_visits){ Visit.confirmed.decorate }
  expose(:doctor_visits){ Visit.where(doctor: current_user).ordered.decorate }

end
