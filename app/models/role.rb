class Role
  include Mongoid::Document

  field :name, type: String

  validates :name, presence: true, uniqueness: true

  has_many :users

end
