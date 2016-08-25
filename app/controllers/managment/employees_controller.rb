class Managment::EmployeesController < ManagmentController

  def index
    @user = User.all.order([:id])
  end

  def create
    employee = Employee.new(employee_params)
    if employee.save
      inventory = Inventory.find(inventory_id: employee.inventory_id)
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

  def destroy_quantity
    employee = Employee.find(params[:id])
     if employee.quantity > params[:quantity].to_i
      employee.update(quantity: "#{employee.quantity - params[:quantity].to_i}")
      respond_to do |format|
        format.json {render json: {"qtt": employee.quantity, "inventory_name": employee.inventory_name, "quantity": params[:quantity].to_i } }
      end
     else
       employee.destroy
       respond_to do |format|
         format.json {render json: {"qtt": "0", "inventory_name": employee.inventory_name, "quantity": params[:quantity].to_i }   }
       end
     end
  end

  def employee_params
    params.require(:employee).permit(:user_id, :inventory_id, :date_of_receipt, :quantity, :inventory_name)
  end


end
