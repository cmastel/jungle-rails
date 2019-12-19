require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      @category = Category.create(name: 'TestCategory')
      # Setup at least two products with different quantities, names, etc
      @product1 = Product.create!(
        name: 'TestProduct',
        price: 20,
        quantity: 3,
        category_id: @category.id)
      @product2 = Product.create!(
        name: 'Another Product',
        price: 20000,
        quantity: 5,
        category_id: @category.id)
      # Setup at least one product that will NOT be in the order
      @product3 = Product.create!(
        name: 'Final Product',
        price: 20000,
        quantity: 8,
        category_id: @category.id)
    end
    # pending test 1
    it 'deducts quantity from products based on their line item quantities' do
      # TODO: Implement based on hints below
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition  what is required)
      @order = Order.new(
        email: 'sample@emai.com',
        total_cents: 50000,
        stripe_charge_id: 'RTG45FRT%'
      )
      # 2. build line items on @order
      @order.line_items.new(
        product: @product1,
        quantity: 1,
        item_price: @product1.price,
        total_price: @product1.price * @product1.quantity
      )
      @order.line_items.new(
        product: @product2,
        quantity: 2,
        item_price: @product2.price,
        total_price: @product2.price * @product2.quantity
      )
      # 3. save! the order - ie raise an exception  it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1.quantity).to eq(2)
      expect(@product2.quantity).to eq(3)
    end
    # pending test 2
    it 'does not deduct quantity from products that are not in the order' do
      # TODO: Implement based on hints in previous test
      @order = Order.new(
        email: 'sample@emai.com',
        total_cents: 50000,
        stripe_charge_id: 'RTG45FRT%'
      )

      @order.line_items.new(
        product: @product1,
        quantity: 1,
        item_price: @product1.price,
        total_price: @product1.price * @product1.quantity
      )
      @order.line_items.new(
        product: @product2,
        quantity: 2,
        item_price: @product2.price,
        total_price: @product2.price * @product2.quantity
      )

      @order.save!
      @product1.reload
      @product2.reload
      @product3.reload

      expect(@product3.quantity).to eq(8)

    end
  end
end