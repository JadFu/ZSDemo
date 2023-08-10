class Item < ApplicationRecord
    has_many :order_items

    # add associations here
    belongs_to :category
  
    def self.ransackable_attributes(auth_object = nil)
        ["category_id", "created_at", "date_create", "discount", "id", "image", "information", "last_update", "name", "price", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["category", "order_items"]
    end

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "item_id", "order_id", "price_ATM", "quantity", "updated_at"]
    end
    # add validations here
    validates :name, presence: true
    validates :information, presence: true
    validates :price, presence: true
    validates :image, presence: true
end