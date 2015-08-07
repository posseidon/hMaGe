class Ticket < ActiveRecord::Base
  attr_accessible :uid, :status
  belongs_to :map
  belongs_to :user
end
