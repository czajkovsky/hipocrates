class User
  include Mongoid::Document

  SEX = ['Not known', 'Male', 'Female', 'Not applicable']

  field :password_hash, type: String
  field :password_salt, type: String

  field :login, type: String
  field :name, type: String
  field :surname, type: String
  field :date_of_birth, type: Date
  field :place_of_birth, type: String
  field :street, type: String
  field :sex, type: String
  field :city, type: String
  field :postal_code, type: String
  field :pesel, type: String
  field :id_number, type: String
  field :id_serial, type: String
  field :phone, type: String
  field :nip, type: String
  field :email, type: String
  field :origin, type: String

  validates :password, confirmation: true, presence: true, on: :create
  validates :login, presence: true, uniqueness: true
  validates :nip, nip: true, if: :nip_present?
  validates :pesel, pesel: true, presence: true, uniqueness: true
  validates :date_of_birth, :sex, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :name, :surname, :city, :place_of_birth, :street, presence: true, length: { minimum: 2 }
  validates :postal_code, presence: true, format: { with: /[0-9]{2}-[0-9]{3}/i }
  validates :id_number, presence: true, format: { with: /\A[0-9]{6}\Z/i }
  validates :id_serial, presence: true, format: { with: /\A[A-Z]{3}\Z/i }
  validates :phone, presence: true, uniqueness: true, format: { with: /\A\+[0-9]{2}\s[0-9]{3}\s[0-9]{3}\s[0-9]{3}\Z/i }

  embeds_one :relative

  before_save :upcase_id_serial
  before_save :encrypt_password
  before_create :generate_credentials
  after_create :assign_role
  after_save :update_active_specialities

  belongs_to :role
  has_and_belongs_to_many :specialities

  has_many :visits, inverse_of: :patient
  has_many :appointments, class_name: 'Visit', inverse_of: :doctor

  attr_accessor :password

  accepts_nested_attributes_for :relative

  scope :by_role, -> (role_name){ where(role: Role.where(name: role_name.to_s).first).order_by('surname asc') }

  def assign_role
    if role.nil?
      self.role = Role.where(name: 'patient').first
      self.save(validate: false)
    end
  end

  def is? role_name
    role.name == role_name.to_s
  end

  def stuff?
    role != 'patient'
  end

  def upcase_id_serial
    self.id_serial = self.id_serial.upcase if id_serial.present?
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(login, password)
    user = User.where(login: login).first
    user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt) ? user : nil
  end

  def nip_present?
    nip.present?
  end

  def to_s
    "#{login} (#{name} #{surname})"
  end

  def age
    now = Time.now.utc.to_date
    now.year - date_of_birth.year - (date_of_birth.to_date.change(year: now.year) > now ? 1 : 0)
  end

  def generate_credentials
    if login.nil?
      logins = User.all.map(&:login)
      begin
        self.login = SecureRandom.hex
        self.password = self.login
      end while logins.include?(self.login)
    end
  end

  def update_active_specialities
    Speciality.all.each do |s|
      s.users.present? ? s.update_attributes(active: true) : s.update_attributes(active: false)
    end
  end

end

