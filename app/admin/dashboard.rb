ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: "Dashboard"

  content title: "All Testing Sites" do
    table_for Host.all do
      column(:name) { |host| 
        "<a target='_blank' href='#{admin_host_path(host)}'>#{host.name}</a>".html_safe
      }
      column :address_1
      column :address_2
      column :city
      column :state
      column :zipcode
    end
  end
end

