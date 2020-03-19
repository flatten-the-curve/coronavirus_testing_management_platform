ActiveAdmin.register Host do
  menu priority: 3, label: "Testing Sites"
  permit_params :name, :address_1, :address_2, :city, :state, :zipcode

  index do
    selectable_column
    id_column
    column :name
    column :address_1
    column :address_2
    column :city
    column :state
    column :zipcode
    actions
  end

  filter :name
  filter :address_1
  filter :address_2
  filter :city
  filter :state
  filter :zipcode

  form do |f|
    f.inputs do
      f.input :name
      f.input :address_1
      f.input :address_2
      f.input :city
      f.input :state
      f.input :zipcode
    end
    f.actions
  end
end
