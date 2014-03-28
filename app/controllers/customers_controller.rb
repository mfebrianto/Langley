class CustomersController < ApplicationController
  def new
  end

  def index
  end

  def create

    #need to be make more elegant
    @customer = Customer.new
    @customer.name = params['name']
    @customer.yaml = params['yaml']

    #this code to send yaml
    @customer.save

    respond_to do |format|
        format.html { render action: 'index' }
    end

  end


  def update

  end

  def show

  end

end
