class TagsController < ApplicationController

  def index
    @tags = ActsAsTaggableOn::Tag.most_used.where("name LIKE (?)", "%#{params[:q]}%").limit(10)
    render json: @tags
  end
end
