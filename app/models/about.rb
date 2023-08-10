class About < ApplicationRecord
    def self.ransackable_attributes(auth_object = nil)
        ["content", "created_at", "id", "title", "updated_at"] # You can adjust this list based on the attributes you want to be searchable
      end
end
