class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:destroy, :edit, :update]

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

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end

  def item_params
    params.require(:item).permit(:title, :category_id, :year, :creator_name, :image_url)
  end
end
