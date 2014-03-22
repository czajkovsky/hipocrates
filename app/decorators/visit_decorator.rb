class VisitDecorator < Draper::Decorator
  delegate_all

  def doctor_label
    "dr #{object.doctor.name} #{object.doctor.surname} <span class='label label-default'>#{object.speciality.name}</span>".html_safe
  end

  def format_date
    object.date.strftime("%d-%m-%y (%H:%M)") if object.date
  end

  def status_label
    text = object.finished? ? 'finished' : (object.confirmed ? 'confirmed' : 'pending')
    classes = { "confirmed" => "success", "finished" => "primary", "pending" => "warning" }
    h.content_tag(:span, text, class: "label label-#{classes[text]}")
  end

end
