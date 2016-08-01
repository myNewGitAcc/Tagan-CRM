class Managment::InventoriesController < AppManagmentController
  def index
    @tech = Inventory.all
  end

  def new

  end

  def create
    @inventory = Inventory.new(inventory_params)
    if  @inventory.valid?
      @inventory.save
      redirect_to managment_inventory_path(@inventory)
    else
      render action: 'new'
    end
  end
  def show
    # @inventory = Inventory.find(params[:id])
  end
  def inventory_params
    params.require(:inventory).permit(:user_id, :inventory_id, :title, :receipt_date, :qtty_in_stock,
    :qtty_of_employees, :avatar)
  end

end

