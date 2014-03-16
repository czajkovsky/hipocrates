class Relative
  include Mongoid::Document

  embedded_in :user

  field :name, type: String
  field :surname, type: String
  field :phone, type: String

  validates :name, length: { minimum: 2 }, if: :name_present?
  validates :surname, length: { minimum: 2 }, if: :surname_present?
  validates :phone, format: { with: /\A\+[0-9]{2}\s[0-9]{3}\s[0-9]{3}\s[0-9]{3}\Z/i }, if: :phone_present?

  def name_present?
    name.present?
  end

  def surname_present?
    surname.present?
  end

  def phone_present?
    phone.present?
  end

end
