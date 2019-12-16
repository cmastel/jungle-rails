require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validation' do
    it 'is valid with valid attributes' do
      @category = Category.new(name: 'TestCategory')
      @category.save!
      @product = Product.new(name: 'TestProduct',
                            price: 20,
                            quantity: 3,
                            category_id: @category.id)
      @product.save!
      expect(@product).to be_valid
    end

    it 'is not valid without a name'
    it 'is not valid without a price'
    it 'is not valid without a quantity'
    it 'is not valid without a category'
  end
end




# it 'should be auto-assigned by AR for saved records' do
#   @category = Category.new( {"name"=>"TestTest"} )
#   @product = Product.new( {
#     "name"=>"TestProduct", 
#       "description"=>"Something....", 
#       "category_id"=>"8", 
#       "quantity"=>"5", 
#       "price"=>"20"
#   } )
#   @product.save!
  
#   expect(@product.id).to be_present
# end

