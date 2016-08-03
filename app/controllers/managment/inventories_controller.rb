class Managment::InventoriesController < ManagmentController

  def index
    @tech = Inventory.all
  end

  def create
    @inventory = Inventory.new(inventory_params)
     if @inventory.valid?
      @inventory.save
      redirect_to managment_inventories_path
     else
       render action: 'new'
     end
  end

  def edit
    @tech = Inventory.find(params[:id])
  end

  def update
    @inventory  = Inventory.find(params[:id])
    if inventory_param
        @inventory.update(inventory_params)
        redirect_to managment_inventories_path
    else
      render action: 'edit'
    end

  end

  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory.destroy
    redirect_to managment_inventories_path

  end

  def show

  end

  def inventory_params
    params.require(:inventory).permit(:user_id, :title, :inventory_id, :date_of_receipt, :quantity_in_stock, :quantity_of_employees)
  end


end
