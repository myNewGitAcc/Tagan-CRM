class Managment::InventoriesController < ManagmentController

  def index
    @tech = Inventory.all.order(:id)
    quantity = Employee.all.order(:inventory_id).group(:inventory_id).sum(:quantity)
    # quantity.each do |k,v|
    #   @tech.each do |i|
    #     if i.id == k
    #      if (i.quantity_of_free -= v) <= 0
    #        i.quantity_of_free = 0
    #      end
    #     end
    #   end
    # end
  end

  def create
    inventory = Inventory.find_by(inventory_name: params[:inventory][:inventory_name])
    if inventory.nil?
      inventory = Inventory.new(inventory_params)
      inventory.save
      Employee.where(inventory_name: params[:inventory][:inventory_name]).update_all(inventory_id: inventory.id)
      quantity = Employee.where(inventory_id: inventory.id).sum(:quantity)
      inventory.quantity_of_free -= quantity
      inventory.update(quantity_of_free: inventory.quantity_of_free)
      respond_to do |format|
        format.json {render json: { result: 'create', id: inventory.id, quantity_in_stock: inventory.quantity_in_stock, quantity: quantity} }
      end
    else
      inventory.update(quantity_in_stock: "#{params[:inventory][:quantity_in_stock].to_i+inventory.quantity_in_stock}",
                       quantity_of_free: "#{params[:inventory][:quantity_in_stock].to_i+inventory.quantity_of_free}")
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
    inventory.update(quantity_in_stock: "#{inventory.quantity_in_stock - params[:quantity].to_i}",
                     quantity_of_free: "#{inventory.quantity_of_free - params[:quantity].to_i}")
    respond_to do |format|
      format.json {render json: {"inventory": inventory,"free": params[:quantity].to_i}  }
    end
  end

  def autocomplete
    @inventories = Inventory.order(:inventory_name).where("#{:inventory_name} LIKE ?", "%#{params[:term]}%")
    respond_to do |format|
      # format.html
      format.json {
        render json: @inventories.map(&:inventory_name).to_json
      }
    end
  end

  def inventory_params
    params.require(:inventory).permit(:inventory_name, :quantity_in_stock, :quantity_of_free, :avatar)
  end


end
