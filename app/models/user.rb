class User
  include Mongoid::Document

  field :email, type: String, default: ''

  field :password_hash, type: String
  field :password_salt, type: String

  field :name, type: String
  field :surname, type: String
  field :date_of_birth, type: Date
  field :place_of_birth, type: String
  field :street, type: String
  field :city, type: String
  field :postal_code, type: String
  field :pesel, type: String
  field :id_number, type: String
  field :id_serial, type: String
  field :phone, type: String
  field :nip, type: String
  field :email, type: String

  validates :name, presence: true

  embeds_one :relative

  after_save :assign_role_on_sign_up
  before_save :encrypt_password

  belongs_to :role
  has_and_belongs_to_many :specialities

  attr_accessor :password

  accepts_nested_attributes_for :relative

  scope :by_role, -> (role_name){ where(role: Role.where(name: role_name.to_s).first).order_by('surname asc') }

  def is? role_name
    role.name == role_name.to_s
  end

  def stuff?
    role != 'patient'
  end

  def assign_role_on_sign_up
    update_attributes(role: Role.where(name: 'patient').first) if role.nil?
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(pesel, password)
    user = User.where(pesel: pesel).first
    user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt) ? user : nil
  end

end

