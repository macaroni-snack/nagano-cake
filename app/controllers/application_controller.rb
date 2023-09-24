class ApplicationController < ActionController::Base
before_action :authenticate_customer!, except: [:top, :about], unless: :admin_signed_in?
before_action :authenticate_admin!, if: :admin_namespace?

  private

  def admin_namespace?
    controller_path.start_with?('admin/')
  end
  
  def after_sign_in_path_for(resource)
    customer_path(current_customer)
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end