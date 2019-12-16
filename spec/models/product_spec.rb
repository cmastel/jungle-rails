require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Product Validation' do
    
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

    it 'is not valid without a name' do
      @category = Category.new(name: 'TestCategory')
      @product = Product.create(name: nil,
                            price: 20,
                            quantity: 3,
                            category_id: @category.id)
      
      expect(@product.errors.full_messages.first).to eq("Name can't be blank")
    end

    it 'is not valid without a price' do
      @category = Category.new(name: 'TestCategory')
      @product = Product.create(name: 'TestProduct',
                            price: nil,
                            quantity: 3,
                            category_id: @category.id)
      
      expect(@product.errors.full_messages.first).to eq("Price cents is not a number")
    end

    it 'is not valid without a quantity' do
      @category = Category.new(name: 'TestCategory')
      @product = Product.create(name: 'TestProduct',
                            price: 20,
                            quantity: nil,
                            category_id: @category.id)
      
      expect(@product.errors.full_messages.first).to eq("Quantity can't be blank")
    end

    it 'is not valid without a category' do
      @product = Product.create(name: 'TestProduct',
                            price: 20,
                            quantity: 3,
                            category_id: nil)
      
      expect(@product.errors.full_messages.first).to eq("Category can't be blank")
    end

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

