class ApplicationController < ActionController::API
  private 
    def check_query key
      if request.query_parameters[key]
        return request.query_parameters[key]
      else
        return false
      end
    end

end
