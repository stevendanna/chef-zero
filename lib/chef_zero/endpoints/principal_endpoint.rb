require 'json'
require 'chef_zero'
require 'chef_zero/rest_base'

module ChefZero
  module Endpoints
    # /principals/NAME
    class PrincipalEndpoint < RestBase
      def get(request)
        name = request.rest_path[-1]
        json = data['users'][name]
        if json
          type = 'user'
        else
          json = data['clients'][name]
          type = 'client'
        end
        if json
          json_response(200, {
            'name' => name,
            'type' => type,
            'public_key' => JSON.parse(json)['public_key'] || PUBLIC_KEY
          })
        else
          error(404, 'Principal not found')
        end
      end
    end
  end
end
