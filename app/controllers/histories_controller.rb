class HistoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @histories = current_user.histories.order("queued DESC").paginate(:page => params[:page], :per_page => 10)
  end
end
