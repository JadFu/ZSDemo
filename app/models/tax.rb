class Tax < ApplicationRecord
    has_many :users

    #validations
    validates :tax_region, presence: true, uniqueness: true
    validates :PST, presence: true
    validates :GST, presence: true
    validates :HST, presence: true
  
    def self.ransackable_attributes(auth_object = nil)
        ["GST", "PST", "created_at", "id", "tax_region", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["orders"]
    end
end