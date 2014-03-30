class Procedure
  include Mongoid::Document

  has_and_belongs_to_many :visits

  field :icd9, type: String
  field :name, type: String

  scope :ordered, -> { order_by('icd9 asc') }

  def self.search search
    where(name: /#{search}/)
  end

end
