class Tax < ApplicationRecord
    has_many :users

    # add validations here
    validates :tax_region, presence: true, uniqueness: true
    validates :PST, presence: true
    validates :GST, presence: true
  
    def self.ransackable_attributes(auth_object = nil)
        ["GST", "PST", "created_at", "id", "tax_region", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["orders"]
    end
    # add associations here (if any)
end