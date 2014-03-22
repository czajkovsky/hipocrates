class Visit
  include Mongoid::Document

  REASONS = ['routine check', 'emergency', 'new client', 'other']

  belongs_to :patient, class_name: 'User', inverse_of: :visits
  belongs_to :doctor, class_name: 'User', inverse_of: :appointments
  belongs_to :speciality
  has_and_belongs_to_many :recognitions

  field :confirmed, type: Boolean, default: false
  field :date, type: DateTime
  field :reason, type: String
  field :note, type: String
  field :procedures, type: String
  field :instructions, type: String

  scope :pending, -> { where(confirmed: false) }
  scope :confirmed, -> { where(confirmed: true) }

  before_save :confirm_visit

  def confirm_visit
    self.confirmed = true if self.date.present?
  end

  def finished?
    self.date < Time.now if self.date
  end

end
