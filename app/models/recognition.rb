class Recognition
  include Mongoid::Document

  field :icd9, type: String
  field :name, type: String

end
