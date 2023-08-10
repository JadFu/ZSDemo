ActiveAdmin.register Contact do
    permit_params :title, :social_links, :contact_details, :team_details
  
    form do |f|
      f.inputs do
        f.input :title
        f.input :social_links
        f.input :contact_details
        f.input :team_details
      end
      f.actions
    end
  end