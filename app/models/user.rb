class User
  include Mongoid::Document

  field :name, type: String
  field :surname, type: String
  field :date_of_birth, type: Date
  field :place_of_birth, type: String
  field :street, type: String
  field :city, type: String
  field :postal_code, type: String
  field :PESEL, type: String
  field :id_number, type: String
  field :id_serial, type: String
  field :phone, type: String
  field :NIP, type: String
  field :email, type: String

end

