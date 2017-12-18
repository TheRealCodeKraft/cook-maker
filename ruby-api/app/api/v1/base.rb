require 'doorkeeper/grape/helpers' 
require "grape-swagger"
require "grape-swagger-representable"

module V1
  class Base < Grape::API

      include Codekraft::Api::Defaults
      helpers Doorkeeper::Grape::Helpers
      include Codekraft::Api::Endpoint

      add_swagger_documentation api_version: "v1"

  end
end

