class Med
  include Mongoid::Document

  has_and_belongs_to_many :visits

  field :name, type: String
  field :dose, type: String
  field :form, type: String
  field :wrapper, type: String

  scope :ordered, -> { order_by('name asc') }

end
