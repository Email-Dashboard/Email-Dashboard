module NotificationContentsHelper

  def has_html?(content)
    strip_tags(content) != content
  end
end
