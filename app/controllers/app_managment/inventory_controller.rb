module AppManagment
  class InventoryController < AppManagmentController
    layout 'managment'
    def inventory
      @tech = Inventory.all
    end
  end
end