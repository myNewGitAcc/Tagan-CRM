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

  def destroy
    @inventory = Inventory.find(param[:id])
    @inventory.destroy
    redirect_to managment_inventories_path
    # respond_to do |format|
    #   format.html { redirect_to managment_inventories_path, notice: 'Profile was successfully destroyed.' }
    # end
  end
end

