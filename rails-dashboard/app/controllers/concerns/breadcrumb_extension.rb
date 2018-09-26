module BreadcrumbExtension
  extend ActiveSupport::Concern

  included do
    before_action :set_list_type, only: [:index, :show, :edit, :new]
    before_action :set_new_type,  only: :new
  end

  def edit
    add_breadcrumb I18n.t('actions.edit')
  end

  private

  def set_list_type
    add_breadcrumb "#{controller_name.titleize}", send("#{controller_name}_path")
  end

  def set_new_type
    add_breadcrumb I18n.t('actions.new')
  end
end
