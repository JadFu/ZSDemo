class Order < ApplicationRecord
    has_many :order_items

    validates :user_id, presence: true
    validates :discount, numericality: true, allow_blank: true
    validates :status_id, presence: true

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "date_create", "discount", "id", "last_update", "status_id", "tax_id", "updated_at", "user_id"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["order_items", "status", "tax", "user"]
    end
    
    belongs_to :user
    belongs_to :status
  
end