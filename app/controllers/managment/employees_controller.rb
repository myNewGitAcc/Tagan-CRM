class Managment::EmployeesController < ManagmentController

  def index
    @user = User.all.order([:id])
  end

  def create
    employee = Employee.new(employee_params)
    if employee.save
     respond_to do |format|
       format.json {render json: { result: 'create'} }
     end
    end
  end

  def insert_data
    result = Employee.where(user_id: "#{params[:user_id]}")
    respond_to do |format|
      format.json {render json: { result: result} }
    end
  end

  def select
    result = Employee.where(user_id: "#{params[:user_id]}")
    respond_to do |format|
      format.json {render json: { result: result} }
    end
  end

  def destroy_employee
    employee = Employee.where(user_id: "#{params[:user_id]}")
    employee.destroy_all
    respond_to do |format|
      format.json {render json: employee  }
    end
  end

  def destroy_quantity
    inventory = Inventory.find(params[:id])
    inventory.update(quantity_in_stock: "#{inventory.quantity_in_stock - params[:quantity].to_i}")
    respond_to do |format|
      format.json {render json: inventory  }
    end
  end

  def employee_params
    params.require(:employee).permit(:user_id, :inventory_id, :date_of_receipt, :quantity, :inventory_name)
  end


end
