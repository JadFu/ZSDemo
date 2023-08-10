class Status < ApplicationRecord
    has_many :orders

    #validations
    validates :name, presence: true, uniqueness: true
    
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "information", "name", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["orders"]
    end
end