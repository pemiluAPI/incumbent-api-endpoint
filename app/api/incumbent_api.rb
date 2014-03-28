module IncumbentApi
  class API < Grape::API
    prefix 'api'
    format :json

    resource :incumbents do
      desc "Return all data incumbent."
      get do
        incumbents = Incumbent.find_all(params)
        {
          results: {
            count: incumbents.count,
            total: Incumbent.find_all(params, true),
            incumbents: incumbents
          } 
        }
      end

      
      desc "Return a incumbent"
      params do
        requires :id, type: String, desc: "incumbent ID."
      end
      route_param :id do
        get do
          incumbent = Incumbent.find_by(id: params[:id])
          incumbent_detail = [incumbent.details] rescue nil
          {
            results: {
              count: (incumbent_detail) ? 1 : 0,
              total: (incumbent_detail) ? 1 : 0,
              incumbents: incumbent_detail
            }
          }
        end
      end
    end
    

    
  end
end