class Med
  include Mongoid::Document

  has_and_belongs_to_many :visits

  field :name, type: String
  field :form, type: String

  scope :ordered, -> { order_by('name asc') }

  def self.search search
    where(name: search)
  end

end
