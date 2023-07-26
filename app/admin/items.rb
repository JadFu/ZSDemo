ActiveAdmin.register Item do
    permit_params :name, :information, :price
  
    remove_filter :name, :information, :price, :image, :discount
  
    index do
      selectable_column
      id_column
      column :name
      column :information
      column :price
      actions
    end
  
    form do |f|
      f.inputs do
        f.input :name
        f.input :information
        f.input :price
      end
      f.actions
    end
  end
