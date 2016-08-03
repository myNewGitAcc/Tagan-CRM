class Managment::InventoriesController < AppManagmentController
  def index
    @invent = Inventory.all
    @type = Type.new
  end

  def new
    @type = Type.all
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
    params.require(:inventory).permit(:user_id,:type_id, :inventory_id, :receipt_date, :avatar)
  end

  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory.destroy
    respond_to do |format|
      format.html { redirect_to managment_inventories_path, notice: 'Inventory was successfully destroyed.' }
    end
  end
end

