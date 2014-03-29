class CustomersController < ApplicationController
  def new
    @customer = Customer.new
  end

  def index
    Rails.logger.info ">>>>>>> 1"

    redis_url = "tcp://localhost:6379/0"  #todo: update to env

    Rails.logger.info ">>>>>>> 2"


    cia = CIA.new(redis_url)

    Rails.logger.info ">>>>>>> #{cia.list}"

    @customer_list = cia.list

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customers }
    end

  end

  def create

    @customer = Customer.new(params[:customer])

    #this code to send yaml
    if @customer.save
      @customer.publish
    else
      Rails.logger.info "todo"
    end

    redirect_to action: "index"

  end

  def update
    @customer = Customer.new(params[:customer])

    #this code to send yaml
    if @customer.save
      @customer.publish
    else
      Rails.logger.info "todo"
    end

    redirect_to action: "index"


  end


  def edit
    redis_url = "tcp://localhost:6379/0"  #todo: update to env
    cia = CIA.new(redis_url)
    @customer = Customer.new
    @customer.name = params[:name]
    @customer.yaml = cia.pull(params[:name])
  end


end
