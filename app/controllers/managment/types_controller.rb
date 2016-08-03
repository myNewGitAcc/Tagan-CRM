class Managment::TypesController < AppManagmentController
  def create
    @type = Type.new(types_params)
    if  @type.valid?
      @type.save
    else
      puts "Midinhjfvuhiebgeiuogtr"
    end
  end

  def types_params
    params.require(:type).permit(:name)
  end
end
