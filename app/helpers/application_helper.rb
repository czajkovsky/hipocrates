module ApplicationHelper

  def rails_view_name
    "#{params[:controller].camelcase.gsub("::", "")}#{params[:action].camelcase.gsub("::", "")}View"
  end

end
