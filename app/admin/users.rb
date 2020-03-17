ActiveAdmin.register User do
  menu priority: 2, label: "Location Officials"
  permit_params :email, :password, :host_id

  index do
    selectable_column
    id_column
    column :email
    column :host_id, "Testing Location" do |user|
      user.host&.name
    end
    actions
  end

  filter :name
  filter :host_id, as: :select, collection: Host.all.map{|x| ["#{x.name}",x.id]}

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :host_id, as: :select, collection: Host.all.map{|x| [x.name,x.id]}

    end
    f.actions
  end

end
