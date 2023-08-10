class User < ApplicationRecord
    has_many :orders
    belongs_to :tax

    # add validations here
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    validates :address, presence: true
  
    # add associations here (if any)
    before_save :set_default_role

    private

    def set_default_role
        self.role ||= 'user'
    end
  end