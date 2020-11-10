# frozen_string_literal: true

class Task < ApplicationRecord
  validates_presence_of :title
end
