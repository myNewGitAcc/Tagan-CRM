class Managment::EmployeesController < ManagmentController

  def index
    @user = User.all.order([:id])
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
     respond_to do |format|
       format.json {render json: { result: 'create'} }
     end
    end
  end

  def insert_data
    @result = Employee.where(user_id: "#{params[:user_id]}")
    respond_to do |format|
      format.json {render json: { result: @result} }
    end
  end

  def employee_params
    params.require(:employee).permit(:user_id, :inventory_id, :date_of_receipt, :quantity, :inventory_name)
  end


end
