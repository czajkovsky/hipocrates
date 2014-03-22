class Recognition
  include Mongoid::Document

  has_and_belongs_to_many :visits

  field :icd10, type: String
  field :name, type: String

  scope :ordered, -> { order_by('icd10 asc') }

end
