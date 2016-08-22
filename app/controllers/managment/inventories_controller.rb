class Managment::InventoriesController < ManagmentController

  def index
    @tech = Inventory.all.order(:id)
    quantity = Employee.all.order(:inventory_id).group(:inventory_id).sum(:quantity)
    quantity.each do |k,v|
      @tech.each do |i|
        if i.id == k
         i.quantity_of_free -= v
        end
      end
    end
  end

  def create
    inventory = Inventory.find_by(inventory_name: params[:inventory_name])
    if inventory.nil?
      inventory = Inventory.new(inventory_params)
      inventory.save
      Employee.where(inventory_name: params[:inventory][:inventory_name]).update_all(inventory_id: @inventory.id)
      quantity = Employee.where(inventory_id: inventory.id).sum(:quantity)
      respond_to do |format|
        format.json {render json: { result: 'create', id: inventory.id, quantity_in_stock: inventory.quantity_in_stock, quantity: quantity} }
      end
    else
      inventory.update(quantity_in_stock: "#{params[:inventory][:quantity_in_stock].to_i+inventory.quantity_in_stock}")
      respond_to do |format|
        format.json {render json: { inventory_name: params[:inventory][:inventory_name], quantity: params[:inventory][:quantity_in_stock] } }
      end
    end
  end

  def destroy_inventory
    inventory = Inventory.find(params[:id])
    Employee.where(inventory_id: params[:id]).update_all(inventory_id: nil)
     inventory.destroy
    respond_to do |format|
      format.json {render json: inventory  }
    end
  end

  def destroy_quantity
    inventory = Inventory.find(params[:id])
    inventory.update(quantity_in_stock: "#{inventory.quantity_in_stock - params[:quantity].to_i}")
    respond_to do |format|
      format.json {render json: inventory  }
    end
  end

  def inventory_params
    params.require(:inventory).permit(:inventory_name, :quantity_in_stock, :quantity_of_free)
  end


end
