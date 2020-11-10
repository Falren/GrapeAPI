# frozen_string_literal: true

class API < Grape::API
  format :json
  formatter :json, Grape::Formatter::ActiveModelSerializers
  error_formatter :json, Grape::Formatter::ActiveModelSerializers
  prefix :api
  version 'v1', using: :path
  helpers do
    def declared_params
      declared(params, includes_missing: false)
    end
  end

  mount API::V1::Application
end
