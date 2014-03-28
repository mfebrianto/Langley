class CustomersController < ApplicationController
  def new
  end

  def index
    redis_url = "tcp://localhost:6379/0"  #todo: update to env
    cia = CIA.new(redis_url)
    customer_list = cia.list

    customer_list.each do |customer|
      puts "#{customer}"
    end


  end

  def create

    #need to be make more elegant
    @customer = Customer.new
    @customer.name = params['name']
    @customer.yaml = params['yaml']

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

  end

  def show

  end

end
