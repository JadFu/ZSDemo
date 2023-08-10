ActiveAdmin.register Category do
  permit_params :name, :description

  index do
    selectable_column
    id_column
    column :name
    column :information
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :information
    end
    f.actions
  end
end
