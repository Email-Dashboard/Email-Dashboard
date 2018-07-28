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

  def tracking_status(status)
    case status
    when 'delivery'
      content_tag(:span, nil, class: "uk-margin-small-right uk-icon", 'uk-icon': 'check', 'uk-tooltip': "title: Delivered")
    when 'bounce'
      content_tag(:span, nil, class: "uk-margin-small-right uk-icon", 'uk-icon': 'ban', 'uk-tooltip': "title: Bounced")
    when 'complaint'
      content_tag(:span, nil, class: "uk-margin-small-right uk-icon", 'uk-icon': 'receiver', 'uk-tooltip': "title: Complained")
    end
  end
end
