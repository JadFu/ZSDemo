class Item < ApplicationRecord
    has_many :order_items
    has_one_attached :image
    belongs_to :category
  
    def self.ransackable_attributes(auth_object = nil)
      ["category_id", "created_at", "date_create", "discount", "id", "information", "last_update", "name", "price", "updated_at"]
    end
  
    def self.ransackable_associations(auth_object = nil)
      ["category", "order_items"]
    end
  
    # add validations here
    validates :name, presence: true, uniqueness: true
    validates :information, presence: true
    validates :price, presence: true
    validates :image, presence: true
  end
  