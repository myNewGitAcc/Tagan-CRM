module API
  class Base < Grape::API
    format :json
    prefix :api

    mount API::V1::Root

  end
end