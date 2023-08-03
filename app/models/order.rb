class Order < ApplicationRecord
    has_many :order_items

    # add associations here
    belongs_to :user
    belongs_to :status
  
end