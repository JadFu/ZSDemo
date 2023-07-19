class Status < ApplicationRecord
    has_many :orders

    # add validations here
    validates :name, presence: true, uniqueness: true
    
    # add associations here (if any)
end