class Item < ApplicationRecord
    has_many :order_items

    # add associations here
    belongs_to :category
  
    # add validations here
    validates :name, presence: true
    validates :information, presence: true
    validates :price, presence: true
    validates :image, presence: true
end