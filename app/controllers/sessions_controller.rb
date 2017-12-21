class SessionsController < Devise::SessionsController

  def new
    redirect_to_auth
    # super
  end

  private

  def redirect_to_auth
    if Rails.env.development?
      redirect_to 'http://lvh.me:3000'
    else
      redirect_to 'http://auth.notifications.svteknoloji.website'
    end
  end
end
