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

    if @customer.valid?
      #this code to send yaml
      if @customer.save
        @customer.publish
        redirect_to action: "index"
      else
        Rails.logger.info "todo"
        render :action => 'new'
      end
    else
      render :action => 'new'
    end



  end

  def update
    @customer = Customer.new(params[:customer])

    if @customer.valid?
      #this code to send yaml
      if @customer.save
        @customer.publish
      else
        render :action => 'edit'
        Rails.logger.info "todo"
      end
    else
      render :action => 'edit'
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
