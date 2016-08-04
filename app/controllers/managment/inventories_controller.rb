class Managment::InventoriesController < AppManagmentController
  def index
    inventoryList = Inventory.all
    typeList = Type.all

    @groupedList = {}
    @typedList = {}
    @resultList = {}
    @counts = Hash.new(0)
    @countsfree = Hash.new(0)
    typeList.each do |item|
      @typedList[item.id] = item.name
    end
    inventoryList.each do |item|
      @groupedList[item.id] = @typedList[item.type_id]

      if item.user_id == nil
        @countsfree[@groupedList[item.id]] += 1
      end
        @counts[@groupedList[item.id]] += 1
    end
    @groupedList = @groupedList.values.uniq
  end

  def new
    @type = Type.all
  end

  def create

    c = params[:count_inv].to_i
    c.times do
      @inventory = Inventory.new(inventory_params)
      if  @inventory.valid?
        @inventory.save
      else
        render action: 'new'
      end
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

