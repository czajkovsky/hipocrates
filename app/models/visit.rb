class Visit
  include Mongoid::Document

  belongs_to :patient, class_name: 'User', inverse_of: :event
  belongs_to :speciality

end
