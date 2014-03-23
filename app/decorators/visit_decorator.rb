class VisitDecorator < Draper::Decorator
  delegate_all

  def doctor_label
    "dr #{object.doctor.name} #{object.doctor.surname} <span class='label label-default'>#{object.speciality.name}</span>".html_safe
  end

  def format_date
    object.date.strftime("%d-%m-%y (%H:%M)") if object.date
  end

  def status_label
    status = object.finished? ? 'finished' : (object.confirmed ? 'confirmed' : 'pending')
    h.content_tag(:span, status, class: "label label-#{context_class}")
  end

  def context_class
    status = object.finished? ? 'finished' : (object.confirmed ? 'confirmed' : 'pending')
    classes = { "confirmed" => "warning", "finished" => "success", "pending" => "danger" }
    classes[status]
  end

end
