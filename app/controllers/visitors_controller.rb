class VisitorsController < ApplicationController
  def index
    if current_user.role == 'user'
      redirect_to questions_path
    else
      redirect_to admin_root_path
    end
  end
end
