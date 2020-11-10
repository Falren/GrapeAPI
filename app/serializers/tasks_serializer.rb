# frozen_string_literal: true

class TasksSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :active
end
