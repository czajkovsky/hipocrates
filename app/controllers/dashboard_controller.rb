class DashboardController < ApplicationController

  expose(:patients_visits){ Visit.where(patient: current_user) }
end
