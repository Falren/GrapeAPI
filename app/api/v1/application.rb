# frozen_string_literal: true

module API
  module V1
    class Application < Grape::API
      mount API::V1::Tasks
      version 'v1'
    end
  end
end
