class Customer
  attr_accessor :name, :yaml

  def save
    Rails.logger.info ">>>>>#{name}>>>>#{yaml}"
    publish
  end

  def publish
    Rails.logger.info ">>>>publish"
  end

end