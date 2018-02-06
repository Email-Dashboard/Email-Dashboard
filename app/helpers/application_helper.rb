module ApplicationHelper
  def flash_class(level)
    case level
    when 'notice' then "uk-alert-primary"
    when 'success' then "uk-alert-success"
    when 'error' then "uk-alert-danger"
    when 'alert' then "uk-alert-danger"
    else 'uk-alert-info'
    end
  end

  def badge_status(status)
    klass = case status
            when 'success' then 'success'
            when 'fail' then 'danger'
            else 'warning'
            end
    content_tag(:span, status.humanize, class: "uk-label uk-label-#{klass}")
  end
end
