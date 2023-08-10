class User < ApplicationRecord
    has_many :orders
    belongs_to :tax

    #validations
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    validates :address, presence: true
    validates :tax_id, presence: true

    before_save :set_default_role

    private

    def set_default_role
        self.role ||= 'user'
    end
  end