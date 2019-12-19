class Order < ActiveRecord::Base
  after_create :update_quantity

  belongs_to :user
  has_many :line_items
  has_many :products, through: :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  private

  def update_quantity
    self.line_items.each do |item|
      product = item.product
      product.quantity -= item.quantity
      product.save!
    end
  end

end
