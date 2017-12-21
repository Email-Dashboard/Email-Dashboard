class SessionsController < Devise::SessionsController
  layout false
  def new
    redirect_to_auth
    # super
  end

  private

  def redirect_to_auth
    if Rails.env.development?
      redirect_to 'http://lvh.me:3000'
    else
      redirect_to 'https://auth.notifications.svteknoloji.website'
    end
  end
end
