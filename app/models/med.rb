class Med
  include Mongoid::Document

  has_and_belongs_to_many :visits

  field :name, type: String
  field :form, type: String

  scope :ordered, -> { order_by('name asc') }

  def self.search search
    where(name: /#{search}/)
  end

  def self.dedupe
    grouped = all.group_by{ |model| [model.name] }
    grouped.values.each do |duplicates|
      first_one = duplicates.shift
      duplicates.each{ |double| double.destroy }
    end
  end

end
