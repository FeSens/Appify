# frozen_string_literal: true

class ApplicationSerializer < ActiveModel::Serializer
  type "data"

  def read_attribute_for_serialization(attr)
    return send(attr) if respond_to?(attr)

    object.send(attr)
  end
end
