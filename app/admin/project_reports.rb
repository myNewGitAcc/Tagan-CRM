ActiveAdmin.register ProjectReport do
  config.batch_actions = false
  includes :company, :user
  permit_params :company_id, :user_id, :tracking_time, :earnings

  filter :created_at

  scope :all

  scope :today, default: true do
    |pr| pr.today
  end

  scope :current_week do
    |pr| pr.week
  end

  scope :current_month do
  |pr| pr.month
  end

  sidebar 'Tracking time statistics current week', :only => :index, priority: 0 do
    company_ids = ProjectReport.get_companies
    table class: 'project_report' do
      Company.find(company_ids).each do |company|
        tr do
          td strong "#{company.name}:"
          td id: company.id do
            h4 ProjectReport.get_time_current_time company.id
          end
        end
      end
    end
    div class: 'week-picker'
  end

  index do
    selectable_column
    id_column
    column 'Project' do |pr|
      pr.company.name
    end
    column 'Developer' do |pr|
      "#{pr.user.first_name} #{pr.user.last_name}"
    end
    column 'Tracking Time' do |pr|
      pr.tracking_time.strftime('%H:%M')
    end
    column  :created_at
    actions
  end

  form do |f|
    f.inputs "Project report" do
      f.input :company_id, as: :select, collection: Company.all.map{ |company| ["#{company.name}", company.id]}
      f.input :user_id, as: :select, collection: User.all.map{ |user| ["#{user.first_name} #{user.last_name}", user.id]}
      f.input :tracking_time
    end
    f.actions
  end

  controller do

    def create
      project_report = ProjectReport.new(permitted_params[:project_report])

      if project_report.save
        flash[:notice] = 'Project Report successfully added'
        redirect_to  admin_project_reports_path
      end
    end

    def update
      pr = ProjectReport.find(params[:id])
      pr.update(permitted_params[:project_report])

      super do |success|
        success.html { redirect_to collection_path }
      end
    end

    def get_tracking_time
      companies = {}
      company_ids = ProjectReport.get_companies
      Company.find(company_ids).each do |company|
        companies["#{company.name}"] = {
                                        id: company.id,
                                        time: ProjectReport.get_time(company.id, params[:start_date], params[:end_date])
                                       }
      end
      respond_to do |format|
          format.json { render json: { companies: companies,
                                       start_data: Date.parse(params[:start_date]).strftime("%d.%m.%Y"),
                                       end_data: Date.parse(params[:end_date]).strftime("%d.%m.%Y")} }
      end
    end

  end

end
