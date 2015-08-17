class TicketsController < ApplicationController
	def new
		@map = Map.find(params[:map_id])
		@ticket = Ticket.new(map_id: @map.id, user_id: current_user.id)
		@request_type = params[:request_type]
	end

	def create
		Ticket.create_request(params)
		redirect_to map_path(params[:ticket][:map_id]), :notice => "#{params[:ticket][:request_type]} Request sent."
	rescue Exception => ex
		@ticket = Ticket.new(map_id: params[:ticket][:map_id], user_id: current_user.id)
		render action: "new"
	end

	def list_my
		@tickets = current_user.tickets.order(:status)
	end

	def list_rejected
		@tickets = Ticket.tickets('REJECTED', current_user.role, params[:page])
	end

	def list_opened
		@tickets = Ticket.tickets('OPEN', current_user.role, params[:page])
	end

	def list_accepted
		@tickets = Ticket.tickets('ACCEPTED', current_user.role, params[:page])
	end

	def list_expired
		#@tickets = Ticket.expired()
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
