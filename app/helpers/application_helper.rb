module ApplicationHelper
  def flash_class(level)
    case level
    when 'notice' then "success"
    when 'success' then "success"
    when 'error' then "danger"
    when 'alert' then "danger"
    else 'warning'
    end
  end

  def badge_status(status)
    klass = case status
            when 'success' then 'success'
            when 'fail' then 'danger'
            when 'scheduled' then 'warning'
            when 'canceled' then 'secondary'
            else 'default'
            end
    content_tag(:span, status.humanize, class: "uk-label uk-label-#{klass}")
  end
end
