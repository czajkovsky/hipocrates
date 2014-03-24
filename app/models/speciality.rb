class Speciality
  include Mongoid::Document

  field :name, type: String
  field :active, type: Boolean, default: false

  validates :name, presence: true, uniqueness: true

  scope :active, -> { where(active: true) }

  has_and_belongs_to_many :users

end
