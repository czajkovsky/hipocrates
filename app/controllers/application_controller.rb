class ApplicationController < ActionController::Base

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

end
