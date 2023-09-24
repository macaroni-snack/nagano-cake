class ApplicationController < ActionController::Base
  before_action :authenticate_customer!, except: [:top, :about], unless: :admin_signed_in?
  before_action :authenticate_admin!, if: :admin_namespace?
  
  def admin_namespace?
    controller_path.start_with?('admin/')
  end
end
