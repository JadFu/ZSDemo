class Category < ApplicationRecord
    has_many :items

    # add validations here
    validates :name, presence: true, uniqueness: true
  
    # add associations here (if any)
  end