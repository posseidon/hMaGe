module TicketsHelper
	def status_to_icon(status)
		if status == 'OPEN'
			"<span class='glyphicon glyphicon-question-sign' aria-hidden='true'></span>".html_safe
		elsif status == 'REJECTED'
			"<span class='glyphicon glyphicon-ban-circle' aria-hidden='true'></span>".html_safe
		elsif status == 'AVAILABLE'
			"<span class='glyphicon glyphicon-ok-circle' aria-hidden='true'></span>".html_safe
		else
			"<span class='glyphicon glyphicon-question-sign' aria-hidden='true'></span>".html_safe
		end
	end
end
