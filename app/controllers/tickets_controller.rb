class TicketsController < ApplicationController
	STATUS = %w[OPEN AVAILABLE REJECTED]

	def new
		@map = Map.find(params[:map_id])
		@ticket = Ticket.new(map_id: @map.id, user_id: current_user.id)
	end

	def create
		@ticket = Ticket.new(params[:ticket])
		@ticket.status = STATUS[0]
		@ticket.uid = Digest::SHA1.hexdigest DateTime.new.to_s
		@ticket.save!
		redirect_to map_path(@ticket.map_id), :notice => "Download request sent."
	rescue Exception => ex
		render action: "new"
	end

	def list_my
		@tickets = current_user.tickets.order(:status)
	end

	def list_rejected
		@tickets = Ticket.rejected(params[:page])
	end

	def list_opened
		@tickets = Ticket.opened(params[:page])
	end

	def list_available
		@tickets = Ticket.available(params[:page])
	end

	def show
		@ticket = Ticket.find(params[:id])
	end

	def update
		@ticket = Ticket.find(params[:id])
		@ticket.update_attributes(params[:ticket])
		@ticket.save!

		if @ticket.status == 'REJECTED'
			# DO NOTHING
		else
			# COPY FILE TO SMB SERVER UNDER FOLDER UID
		end

		redirect_to ticket_path(@ticket.id), :notice => "Ticket Saved."
	end

end
