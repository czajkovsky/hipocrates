class VisitDecorator < Draper::Decorator
  delegate_all

  def doctor_label
    "dr #{object.doctor.name} #{object.doctor.surname} <span class='label label-default'>#{object.speciality.name}</span>".html_safe
  end

  def format_date
    object.date.strftime("%H:%M (%d-%m-%y)")
  end

end
