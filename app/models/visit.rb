class Visit
  include Mongoid::Document

  belongs_to :patient, class_name: 'User', inverse_of: :visits
  belongs_to :doctor, class_name: 'User', inverse_of: :appointments
  belongs_to :speciality

  field :confirmed, type: Boolean, default: false
  field :date, type: DateTime

  scope :pending, -> { where(confirmed: false) }
  scope :confirmed, -> { where(confirmed: true) }

end
