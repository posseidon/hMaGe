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
      Map.human_attribute_name("processed").html_safe
    else
      Map.human_attribute_name("unprocessed").html_safe
    end
  end
end
