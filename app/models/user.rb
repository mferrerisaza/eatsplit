class User < ApplicationRecord
  has_one :profile
  has_many :orders
  has_many :bills, through: :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
