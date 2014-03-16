class DashboardController < ApplicationController

  expose(:patient_visits){ Visit.where(patient: current_user).decorate }
  expose(:pending_visits){ Visit.pending.decorate }

end
