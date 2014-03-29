class CustomersController < ApplicationController
  def new
    @customer = Customer.new
  end

  def index
    redis_url = "tcp://localhost:6379/0"  #todo: update to env
    cia = CIA.new(redis_url)
    @customer_list = cia.list
  end

  def create

    @customer = Customer.new(params[:customer])

    #this code to send yaml
    if @customer.save
      @customer.publish
    else
      Rails.logger.info "todo"
    end

    respond_to do |format|
        format.html { render action: 'index' }
    end

  end

  def update
    Rails.logger.info ">>>> invoke update"
    @customer = Customer.new(params[:customer])

    #this code to send yaml
    if @customer.save
      @customer.publish
    else
      Rails.logger.info "todo"
    end

    respond_to do |format|
      format.html { render action: 'index' }
    end


  end


  def edit
    redis_url = "tcp://localhost:6379/0"  #todo: update to env
    cia = CIA.new(redis_url)
    @customer = Customer.new
    @customer.name = params[:name]
    @customer.yaml = cia.pull(params[:name])
  end


end
