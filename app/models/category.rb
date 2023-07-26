class Category < ApplicationRecord
    has_many :items

    # add validations here
    validates :name, presence: true, uniqueness: true
  
    def self.ransackable_attributes(auth_object = nil)
      %w[created_at id information name updated_at]
    end

    def self.ransackable_associations(auth_object = nil)
      ["items"]
    end
    # add associations here (if any)
  end