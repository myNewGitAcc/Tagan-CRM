ActiveAdmin.register Scheduler do
  config.batch_actions = false
  permit_params :frequency, :time, :day, :name, :task_raw, :type

  index do
    selectable_column
    id_column

    column :type
    column :frequency

    column :time do |t|
      t.time.strftime('%H:%M:%S')
    end
    column :last_run do |scheduler|
      scheduler.jobs.first.last_run.strftime('%B %d, %Y') rescue nil
    end
    column :next_due do |scheduler|
      scheduler.jobs.first.scheduled_at.strftime('%B %d, %Y') rescue nil
    end
    actions
  end

  filter :frequency

  form do |f|
    f.inputs 'Shedulers' do
      if (request.original_url.include?(new_admin_scheduler_path) rescue false)
        f.input :name, as: :select, collection: %w(Scheduler::RssReadersImport), include_blank: false
      end

      f.input :task_raw, as: :hidden
      f.input :time, label: 'Time (Hours/minutes)'
      f.input :frequency, as: :select, collection: %W(#{'every 20 seconds'} #{'every minute'} #{'every 3 minutes'}), include_blank: false
    end
    f.actions
  end

  controller do

    def create
      scheduler = Scheduler::const_get(permitted_params[:scheduler][:name]).create(permitted_params[:scheduler])
      unless scheduler.nil?
        flash[:notice] = 'Scheduler successfully added'
        redirect_to  admin_schedulers_path
      end
    end

    def update
      super do |success|
        success.html { redirect_to collection_path }
      end
    end
  end
end