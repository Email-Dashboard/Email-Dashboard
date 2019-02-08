class TestModesController < ApplicationController
  # toggle show test mode
  def update
    session[:show_test_mode] = session[:show_test_mode].present? ? nil : 'enabled'
  end
end
