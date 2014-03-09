class UserDecorator < Draper::Decorator
  delegate_all

  def label_class
    classes = { "patient" => "success", "doctor" => "primary", "nurse" => "info", "admin" => "danger", "office" => "warning" }
    classes[self.role.name] if self.role.present?
  end

  def list_specialities
    self.specialities.map{ |s| s.name }.to_sentence
  end

end
