module API
  module Concern::WorkingTime
    extend ActiveSupport::Concern
    included do

      segment :working_time do
        desc "Return all working time"

        params do
          optional :access_token, type: String, desc: 'User access token'
        end

        get '/:id' do
          begin
            user = User.find(params[:id])
            timings = user.working_times
            success! timings.as_api_response(:basic), 200
          rescue => e
            throw_error! 403, e.class.to_s, e.message
          end
        end

        desc "Update working time"
        params do
          requires  :created_at, type: DateTime, desc: 'Working day YYYY-MM-DD'
          optional  :access_token, type: String, desc: 'User access token'
          optional  :status_change_date, type: DateTime, desc: 'YYYY-MM-DD HH:MM:SS'
          optional  :labor_hours, type: Integer, desc: 'Hours worked'
        end

        put ':id' do
          begin
            user = User.find(params[:id])
            selected_date = params[:created_at]
            timing = user.working_times.find_by(created_at: selected_date.beginning_of_day..selected_date.end_of_day)

            working_time_params = ActionController::Parameters.new(params).permit(:status_change_date, :labor_hours)
            timing.update_attributes(working_time_params)

            success! timing.as_api_response(:basic), 200
          rescue => e
            throw_error! 403, e.class.to_s, e.message
          end
        end

        desc "Return working day"
        params do
          requires  :user_id, type: Integer, desc: 'User id'
          requires  :created_at, type: DateTime, desc: 'Working day YYYY-MM-DD'
          optional  :access_token, type: String, desc: 'User access token'
        end

        get do
          begin
            user = User.find(params[:user_id])
            selected_date = params[:created_at]
            timing = user.working_times.find_by(created_at: selected_date.beginning_of_day..selected_date.end_of_day)

            success! timing.as_api_response(:basic), 200
          rescue => e
            throw_error! 403, e.class.to_s, e.message
          end
        end
      end
    end
  end
end
