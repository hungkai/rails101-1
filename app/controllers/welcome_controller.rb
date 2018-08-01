class WelcomeController < ApplicationController
  def index
    flash[:warning] = "Warning message！"
  end
end
