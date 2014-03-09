class Speciality
  include Mongoid::Document

  field :name, type: String

  validates :name, presence: true, uniqueness: true

  has_and_belongs_to_many :users

end
