class Relative
  include Mongoid::Document

  embedded_in :user

  field :name, type: String
  field :surname, type: String
  field :phone, type: String

end
