module Admin
  class DashboardController < Admin::BaseController
    def index
      @users = User.non_admin.page(params[:page]).per(params[:per] || 10).eager_load(:questions)
    end
  end
end