class Managment::InventoriesController < ManagmentController

  def index
    @tech = Inventory.all
  end

  def create
    @inventory = Inventory.new(inventory_params)
     if @inventory.valid?
      @inventory.save
      redirect_to admin_user_path(@inventory)
     else
       render action: 'new'
     end
  end

  def show
    Inventory.all
  end

  def inventory_params
    params.require(:inventory).permit(:user_id, :invented_id, :date_of_receipt, :guantity_in_stock, :quantity_of_emploees)
  end

end
