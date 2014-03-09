class User
  include Mongoid::Document

  field :name, type: String
  field :surname, type: String

end

