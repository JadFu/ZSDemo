class Contact < ApplicationRecord
    def self.ransackable_attributes(auth_object = nil)
        ["contact_details", "created_at", "id", "social_links", "team_details", "title", "updated_at"] # You can adjust this list based on the attributes you want to be searchable
      end
end
