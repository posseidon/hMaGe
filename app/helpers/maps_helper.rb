module MapsHelper
  def status_to_icon(status)
    if status
      "fa fa-check-square-o icon pull-right".html_safe
    else
      "fa fa-square-o icon pull-right".html_safe
    end
  end

  def status_to_text(status)
    if status
      " processed".html_safe
    else
      " unprocessed".html_safe
    end
  end
end
