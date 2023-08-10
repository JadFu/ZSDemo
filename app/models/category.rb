class Category < ApplicationRecord
    has_many :items

    #validations
    validates :name, presence: true, uniqueness: true
  
    def self.ransackable_attributes(auth_object = nil)
      %w[created_at id information name updated_at]
    end

    def self.ransackable_associations(auth_object = nil)
      ["items"]
    end
  end