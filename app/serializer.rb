class Serializer
  attr_reader :object

  def initialize(object)
    @object = object
  end

  def self.attribute(attribute_name, &block)
    attributes << [attribute_name, block]
  end

  def self.attributes
    @attributes ||= []
  end

  def serialize
    self.class.attributes.each_with_object({}) do |(attribute_name, block), result|
      block ||= proc { object.public_send(attribute_name) }
      result[attribute_name] = instance_eval(&block)
    end
  end
end
