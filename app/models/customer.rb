class Customer
  attr_accessor :name, :yaml

  def save
    redis_url = "tcp://localhost:6379/0"  #todo: update to env
    cia = CIA.new(redis_url)
    cia.push(name, yaml)
  end

  def publish
    redis = Redis.new
    redis.publish 'langley-publish', yaml
  end

end