class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :orders
    belongs_to :tax

    # add validations here
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    validates :address, presence: true
  
    # add associations here (if any)
    before_save :set_default_role

    def self.ransackable_attributes(auth_object = nil)
        ["address", "created_at", "email", "id", "password", "role", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["orders"]
    end
    
    private

    def set_default_role
        self.role ||= 'user'
    end
  end