class User < ActiveRecord::Base
  has_many :tickets, dependent: :destroy
  ROLES = %w[admin editor viewer librarian]
  paginates_per 10

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable
  validates_uniqueness_of :email, :on => :create
  validates :name, :email, :password, presence: true, :on => :create
  validates :password, :presence =>true, :confirmation => true, :on => :create

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :role
end
