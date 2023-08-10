ActiveAdmin.register Item do
  permit_params :name, :category_id, :information, :price, :image, :discount

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
      f.input :discount
      f.input :image # Use this field to update the image
    end

    # Separate form element for the image file input
    inputs 'Update Image' do
      file_field_tag 'new_image_upload' # Use file_field_tag to create an input field for the image file
    end

    f.actions
  end

  before_save do |item|
    item.last_update = Time.now
    if params[:new_image_upload].present? # Check if a new image is attached
      # Rename the image and save it to the assets image directory
      new_image_name = "#{item.id}.jpg"
      uploaded_file = params[:new_image_upload]
      File.open(Rails.root.join('app', 'assets', 'images', new_image_name), 'wb') do |file|
        file.write(uploaded_file)
      end
      item.image = new_image_name # Update the image column with the new image name
    else
      item.image = "noItem.jpg" # Set the default image if no new image is attached
    end
  end
end








