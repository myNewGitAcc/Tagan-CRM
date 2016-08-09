class Managment::EmployeesController < ManagmentController

  def index
    @tech = Inventory.all.order(:id)
  end

end
