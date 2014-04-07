require 'v1/incumbent_api.rb'

module Base
  class API < Grape::API
    mount IncumbentApi::APIv1
  end
end
