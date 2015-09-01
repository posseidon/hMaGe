class Ticket < ActiveRecord::Base
  STATUS = %w[OPEN ACCEPTED REJECTED CLOSED]
  REQUEST_TYPE = %w[DOWNLOAD UPDATE]

  attr_accessible :uid, :status, :message, :user_id, :map_id, :request_type
  belongs_to :map
  belongs_to :user
  paginates_per 10

  def Ticket.tickets(status, role, page=0)
    if role.eql? 'librarian'
      Ticket.by_status_and_request_type(status, 'DOWNLOAD', page)
    else
      Ticket.by_status_and_request_type(status, 'UPDATE', page)
    end    
  end

  def Ticket.by_status_and_request_type(status, request_type, page)
    self.where("status = '#{status}' and request_type = '#{request_type}'").page(page)
  end

  def Ticket.my_tickets(status, on_request, by_user, page=0)
    self.where("status = '#{status}' and request_type = '#{on_request}' and user_id = #{by_user.id}").page(page)
  end

  def Ticket.expired(page)
    self.where("status = 'ACCEPTED' and request_type = 'DOWNLOAD' and CURRENT_TIMESTAMP > (updated_at + cast('1 day' as interval)*2").page(page)
  end

  def Ticket.create_request(params)
    ticket = Ticket.new(params[:ticket])
    ticket.status = STATUS[0]
    ticket.uid = Digest::SHA1.hexdigest DateTime.now.to_s
    ticket.save!
  end

  def Ticket.can_user_request_download_ticket(user_id, map_id)
    # DO NOT ALLOW DOWNLOAD REQUEST IF
    # A. NOT APPROVED
    # B. DOWNLOAD GRANTED WITHIN 2 WEEKS
    #@tickets = Ticket.where("user_id = #{user_id} and map_id = #{map_id} and ((status = 'OPEN') or (status = 'ACCEPTED' and CURRENT_TIMESTAMP < (updated_at + cast('1 day' as interval)*14 )))")

    # DO NOT ALLOW DOWNLOAD REQUEST IF
    # A. NOT APPROVED
    # B. HAVE BEEN APPROVED
    Ticket.where("request_type = 'DOWNLOAD' and user_id = #{user_id} and map_id = #{map_id} and status in ('OPEN', 'ACCEPTED')")
  end

  def Ticket.can_user_request_update_ticket(user_id, map_id)
    Ticket.where("request_type = 'UPDATE' and user_id = #{user_id} and map_id = #{map_id} and status in ('OPEN')")
  end
end
