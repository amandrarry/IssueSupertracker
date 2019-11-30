class ApplicationController < ActionController::Base
  before_action :set_current_user

  def current_user
      @current_user
  end
  helper_method :current_user


  def set_current_user
    User.create()
    if User.find(1)
  	  @user = User.find(1)
      @current_user = @user
    end
  end

end