module ApplicationHelper
	def user_role_to_icon
        if current_user.role.eql? 'admin'
        	"<i class='glyphicon glyphicon-tower icon'></i> &nbsp;".html_safe
        elsif current_user.role.eql? 'viewer'
        	"<i class='fa fa-user icon'></i> &nbsp;".html_safe
        elsif current_user.role.eql? 'editor'
        	"<i class='fa fa-users icon'></i> &nbsp;".html_safe
        else
        	"<i class='fa fa-university icon'></i> &nbsp;".html_safe
        end
	end
end
