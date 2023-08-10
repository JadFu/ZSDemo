class Status < ApplicationRecord
    has_many :orders

    # add validations here
    validates :name, presence: true, uniqueness: true
    
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "information", "name", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["orders"]
    end
    # add associations here (if any)
end