class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["AUTH_NAME"],
  password: ENV["AUTH_PASSWORD"]
    def show
      @product_count = Product.all.count
      @catagory_count = Category.all.count
    end
end

