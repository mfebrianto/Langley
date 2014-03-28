class CustomersController < ApplicationController
  def new
  end

  def index
  end

  def create
    comments_from_form = params['comment']
    Rails.logger.info ">>>>>#{comments_from_form}"

    respond_to do |format|
        format.html { render action: 'index' }
    end

  end

  def update

  end

  def show

  end

end
