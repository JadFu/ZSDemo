class OrderItem < ApplicationRecord
    # add associations here
    belongs_to :order
    belongs_to :item
  
    # add validations here
    validates :price_ATM, presence: true
    validates :quantity, presence: true
end