class User < ActiveRecord::Base
  ROLES = %w[admin editor viewer]
  paginates_per 10

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable
  validates_uniqueness_of :email
  validates :name, :email, :password, presence: true
  validates :password, :presence =>true, :confirmation => true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :role
end
