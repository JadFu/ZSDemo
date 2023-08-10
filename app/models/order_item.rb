class OrderItem < ApplicationRecord
    # add associations here
    belongs_to :order
    belongs_to :item
  
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "item_id", "order_id", "price_ATM", "quantity", "updated_at"]
    end
    # add validations here
    validates :price_ATM, presence: true
    validates :quantity, presence: true
end