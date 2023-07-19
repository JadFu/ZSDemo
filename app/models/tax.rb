class Tax < ApplicationRecord
    has_many :orders

    # add validations here
    validates :tax_region, presence: true, uniqueness: true
    validates :PST, presence: true
    validates :GST, presence: true
  
    # add associations here (if any)
end