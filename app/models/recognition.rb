class Recognition
  include Mongoid::Document

  has_and_belongs_to_many :visits

  field :icd10, type: String
  field :name, type: String

end