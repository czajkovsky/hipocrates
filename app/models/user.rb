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

  embeds_one :relative

  belongs_to :role
  has_and_belongs_to_many :specialities

  accepts_nested_attributes_for :relative

  scope :patients, -> { where(role: Role.where(name: 'patient').first).order_by('surname asc') }

  def is? role_name
    role.name == role_name.to_s
  end

  def stuff?
    role != 'patient'
  end

end

