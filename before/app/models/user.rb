class User < ApplicationRecord
  attr_accessor :changing_password, :original_password, :new_password

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
  validates :password, length: { minimum: 6 }, on: :create

  validate :verify_original_password, if: :changing_password
  validates :original_password, :new_password, presence: true, if: :changing_password
  validates :new_password, confirmation: true, if: :changing_password
  validates :new_password, length: { minimum: 6 }, if: :changing_password

  before_update :change_password, if: :changing_password

  def verify_original_password
    unless password == original_password
      errors.add :original_password, "is not correct"
    end
  end

  def change_password
    self.password = new_password
  end
end
