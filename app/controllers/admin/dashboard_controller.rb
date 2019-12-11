class Admin::DashboardController < ApplicationController
  
  http_basic_authenticate_with name: ENV['USER_NAME'], password: ENV['PASSWORD']

  def show
    @product_count = Product.count(:all)
    @category_count = Category.count(:all)

  end
end
