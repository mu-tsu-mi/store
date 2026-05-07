class ProductsController < ApplicationController
  # %i: shorthand for creating an array of symbols(:show, :edit, :update)
  before_action :set_product, only: %i[show edit update destroy]
  
  def index
    @products = Product.all
  end

  def show
    # replaced by before_action
    # @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    # product_params method:tell Rails to inspect the params and ensure there is a key named :product with an array of parameters as the value. The only permitted parameters for products is :name and Rails will ignore any other parameters.  
    @product = Product.new(product_params)

    # When redirect_to is given an Active Record object, Rails generates a path for that record's "show action".
    if @product.save
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # replaced by before_action
    # @product = Product.find(params[:id])
  end

  def update
    # replaced by before_action
    # @product = Product.find(params[:id])
    if @product.update(product.params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    # redirect_to:(Rails method): Send HTTP redirect res to client to make a new req.
    # products_path: a path helper that generates the URL for the index action of the ProductsController (ex: /products)
    redirect_to products_path
  end

  # private: available only within the class
  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.expect(product: [ :name ])
    end

end
