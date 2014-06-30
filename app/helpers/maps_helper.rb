module MapsHelper
  def status_to_icon(status)
    if status
      "<i class='glyphicon glyphicon-ok-sign'> processed</i>".html_safe
    else
      "<i class='glyphicon glyphicon-question-sign'> unprocessed</i>".html_safe
    end
  end
end
