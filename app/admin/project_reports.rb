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

  sidebar 'General Stats', :only => :index, priority: 0 do
    table do
      tr do
        td strong 'Earnings for today:'
        td h4 number_to_currency(ProjectReport.today.sum(:earnings))
      end

      tr do
        td strong 'Earnings for current week:'
        td h4 number_to_currency(ProjectReport.week.sum(:earnings))
      end

      tr do
        td strong 'Earnings for current month:'
        td h4 number_to_currency(ProjectReport.month.sum(:earnings))
      end
    end
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
    column('Earnings') {|t| number_to_currency t.earnings}
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

    def scoped_collection
      ProjectReport.includes(:user)
    end


    def create
      project_report = ProjectReport.new(permitted_params[:project_report])

      project_report.earnings = get_earnings company

      if project_report.save
        flash[:notice] = 'Project Report successfully added'
        redirect_to  admin_project_reports_path
      end
    end

    def update
      company = Company.find(permitted_params[:project_report][:company_id])
      pr = ProjectReport.find(params[:id])
      pr.earnings = get_earnings company
      pr.update(permitted_params[:project_report])

      super do |success|
        success.html { redirect_to collection_path }
      end
    end

    def get_earnings company
      hour = permitted_params[:project_report][:'tracking_time(4i)'].to_i
      minute = permitted_params[:project_report][:'tracking_time(5i)'].to_i

      return  hour * company.rates.last.amount if minute == 0
      return  (hour * company.rates.last.amount) +  (company.rates.last.amount / (60 / minute).to_d)
    end

  end

end
