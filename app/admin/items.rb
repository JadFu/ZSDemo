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
        f.input :category
        f.input :information
        f.input :price
        f.input :image
        f.input :discount
      end
      f.actions
    end
  
    before_save do |item|
      item.last_update = Time.now
    end
  end
