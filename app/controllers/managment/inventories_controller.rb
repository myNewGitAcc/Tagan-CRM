class Managment::InventoriesController < ManagmentController

  def index
    @tech = Inventory.all.order(:id)
  end

  def create
    @inventory = Inventory.find_by(inventory_name: params[:inventory][:inventory_name])
    puts(@inventory)
    if @inventory.nil?
      @inventory = Inventory.new(inventory_params)
      @inventory.save
      respond_to do |format|
        format.json {render json: { result: 'create'} }
      end
    else
      @inventory.update(quantity_in_stock: "#{params[:inventory][:quantity_in_stock].to_i+@inventory.quantity_in_stock}")
      respond_to do |format|
        format.json {render json: { inventory_name: params[:inventory][:inventory_name], quantity: params[:inventory][:quantity_in_stock] } }
      end
    end
  end

  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory.destroy
    redirect_to managment_inventories_path

  end

  def inventory_params
    params.require(:inventory).permit(:inventory_name, :quantity_in_stock)
  end


end
