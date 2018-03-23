class User < ApplicationRecord
  has_one :profile
  has_many :restaurants
  has_many :orders
  has_many :bills, through: :orders
  before_create :create_profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def create_profile
    self.profile = Profile.create(name: self.email.split("@")[0])
  end
end
