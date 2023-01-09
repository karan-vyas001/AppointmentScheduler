class User < ApplicationRecord
  rolify
  has_many :availabilities
  has_many :appointments
  belongs_to :organization
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def full_name
    "#{first_name} #{last_name}"
  end
end
