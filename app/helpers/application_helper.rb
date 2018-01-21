module ApplicationHelper
  def flash_class(level)
    case level
    when 'notice' then "alert alert-info"
    when 'success' then "alert alert-success"
    when 'error' then "alert alert-danger"
    when 'alert' then "alert alert-danger"
    else 'alert alert-info'
    end
  end

  def badge_status(status)
    klass = case status
            when 'success' then 'success'
            when 'fail' then 'danger'
            else 'warning'
            end
    content_tag(:span, status.humanize, class: "badge badge-pill badge-#{klass}")
  end
end
