class HistoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:type] == 'all' || params[:type].nil?
      @histories = current_user.histories.order("queued DESC").paginate(:page => params[:page], :per_page => 10)
    elsif params[:type] == 'delivered'
      @histories = current_user.histories.delivered.order("queued DESC").paginate(:page => params[:page], :per_page => 10)
    elsif params[:type] == 'not_delivered'
      @histories = current_user.histories.not_delivered.order("queued DESC").paginate(:page => params[:page], :per_page => 10)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
