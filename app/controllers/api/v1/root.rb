module API
  module V1
    class Root < Grape::API
      version 'v1'
      include API::Concern::Status

    end
  end
end
