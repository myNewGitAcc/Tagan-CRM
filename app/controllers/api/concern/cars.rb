module API
  module Concern::Cars

    extend ActiveSupport::Concern
    included do

      segment :cars do
        desc "Return Cars data."

        get '/cars' do
          cars = Car.all
          success!(cars.as_api_response(:basic), status)
        end

        desc "Add new cars"
        params do
          optional :user_id, type: Integer, desc: "User id"
          requires :name, type: String, desc: 'Cars name'
          requires :is_stock, type: String, desc: 'Car is stock?'
          requires :max_speed, type: Integer, desc: 'Cars max speed'
          requires :price, type: Integer, desc: 'Car price'
        end

        post do
          car_hash = params.slice(:name, :is_stock, :max_speed, :price, :user_id)# unless car_hash

          params[:car] = car_hash
          permitted_params = permit_params(:car, Permits.controller(Car.name))

          car = Car.create(permitted_params)
          after_save(car, status, "Car is added succesfully")
        end

        desc "Delete cars"
        params do
          optional :user_id, type: Integer, desc: 'Cars foreign key'
        end

        delete ':id' do
          begin
            car = Car.find_by_id params[:id]
            car.destroy
            success! car.as_api_response(:basic), 200
          rescue => e
            throw_error! 403, e.class.to_s, e.message
          end
        end

        desc "Update cars"
        params do
          optional :user_id, type: Integer, desc: "User id"
          optional :name, type: String, desc: 'Cars name'
          optional :is_stock, type: String, desc: 'Car is stock?'
          optional :max_speed, type: Integer, desc: 'Cars max speed'
          optional :price, type: Integer, desc: 'Car price'
        end

        put ':id' do
            car = Car.find_by_id params[:id]
            car_params = ActionController::Parameters.new(params).permit(:name, :is_stock, :max_speed, :price, :user_id)
            car.update_attributes(car_params)
            success! car.as_api_response(:basic), 200
        end

        desc "Desktop all cars"
        get ':id' do
          car = Car.find_by_id params[:id]
          success! car.as_api_response(:basic), 200
        end

      end
    end
  end
end
