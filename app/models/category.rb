class Category < ActiveRecord::Base

  has_many :products

  def product_count
    Product.where(category_id: id).count
  end

end
