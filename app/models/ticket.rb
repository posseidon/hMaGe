class Ticket < ActiveRecord::Base
  attr_accessible :uid, :status, :message, :user_id, :map_id
  belongs_to :map
  belongs_to :user
  paginates_per 10

  def Ticket.opened(page)
  	self.where("status = 'OPEN'").page(page)
  end

  def Ticket.available(page)
  	self.where("status = 'AVAILABLE'").page(page)
  end

  def Ticket.rejected(page)
  	self.where("status = 'REJECTED'").page(page)
  end
end
