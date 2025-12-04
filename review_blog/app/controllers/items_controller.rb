class ItemsController < ApplicationController
  #prevents repetition of code by setting the item for specific actions
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all.order(:title)
  end

  def show
    @reviews = @item.reviews.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item, notice: "Item created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: "Item updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to items_path, notice: "Item deleted!"
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:title, :category_id, :year, :creator_name, :image_url)
  end
end
