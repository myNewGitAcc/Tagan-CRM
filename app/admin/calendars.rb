ActiveAdmin.register_page "Calendars" do

  content do
    render partial: 'calendar'
  end

  controller do
    def index
      @events = Event.all
    end
  end

end
