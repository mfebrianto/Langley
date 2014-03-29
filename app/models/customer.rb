class Customer
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :yaml

  validates_presence_of :name, :yaml

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def save
    redis_url = "tcp://localhost:6379/0"  #todo: update to env
    cia = CIA.new(redis_url)
    cia.push(name, yaml)
  end

  def publish
    redis = Redis.new
    redis.publish 'langley-publish', yaml
  end

  def persisted?
    false
  end


end