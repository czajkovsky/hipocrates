class User
  include Mongoid::Document

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  field :email, type: String, default: ''
  field :encrypted_password, type: String, default: ''

  field :reset_password_token, type: String
  field :reset_password_sent_at, type: Time

  field :remember_created_at, type: Time

  field :sign_in_count, type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at, type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip, type: String

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

  after_create :assign_role_on_sign_up

  belongs_to :role
  has_and_belongs_to_many :specialities

  accepts_nested_attributes_for :relative

  scope :by_role, -> (role_name){ where(role: Role.where(name: role_name.to_s).first).order_by('surname asc') }

  def is? role_name
    role.name == role_name.to_s
  end

  def stuff?
    role != 'patient'
  end

  def assign_role_on_sign_up
    update_attributes(role: Role.where(name: 'patient').first)
  end

end

