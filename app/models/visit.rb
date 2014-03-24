class Visit
  include Mongoid::Document

  REASONS = ['routine check', 'emergency', 'new client', 'other']

  belongs_to :patient, class_name: 'User', inverse_of: :visits
  belongs_to :doctor, class_name: 'User', inverse_of: :appointments
  belongs_to :speciality
  has_and_belongs_to_many :recognitions
  has_and_belongs_to_many :procedures
  has_and_belongs_to_many :meds

  field :confirmed, type: Boolean, default: false
  field :date, type: DateTime
  field :reason, type: String
  field :note, type: String
  field :instructions, type: String

  scope :ordered, -> { order_by('confirmed asc').order_by('date desc') }
  scope :pending, -> { where(confirmed: false) }
  scope :confirmed, -> { where(confirmed: true).order_by('date desc') }

  before_save :confirm_visit

  def confirm_visit
    self.confirmed = true if self.date.present?
  end

  def finished?
    self.date < Time.now if self.date
  end

  def can_see?(user)
    user.is?(:office) or user.is?(:admin) or self.doctor == user or self.patient == user
  end

  def self.remind
    Visit.all.each do |v|
      if v.date.present? and v.date.to_date > Time.now.to_date and (v.date.to_date - Time.now.to_date) == 1
        PatientMailer.remind(v).deliver if v.patient.email.present?
      end
    end
  end

end
