ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    columns do
      column do
        panel "Recent Orders" do
          ul do
            Order.order(created_at: :desc).limit(10).map do |order|
              li link_to(order.id, admin_order_path(order))
            end
          end
        end
      end

      column do
        panel "Recent Items" do
          ul do
            Item.order(created_at: :desc).limit(10).map do |item|
              li link_to(item.id, admin_item_path(item))
            end
          end
        end
      end

      column do
        panel "Recent Users" do
          ul do
            User.order(created_at: :desc).limit(10).map do |user|
              li link_to(user.id, admin_user_path(user))
            end
          end
        end
      end

      column do
        panel "Recent Categories" do
          ul do
            Category.order(created_at: :desc).limit(10).map do |category|
              li link_to(category.id, admin_category_path(category))
            end
          end
        end
      end

      column do
        panel "Recent Admin Users" do
          ul do
            AdminUser.order(created_at: :desc).limit(10).map do |admin_user|
              li link_to(admin_user.id, admin_admin_user_path(admin_user))
            end
          end
        end
      end

      column do
        panel "Recent Order Items" do
          ul do
            OrderItem.order(created_at: :desc).limit(10).map do |order_item|
              li link_to(order_item.id, admin_order_item_path(order_item))
            end
          end
        end
      end

      column do
        panel "Recent Taxes" do
          ul do
            Tax.order(created_at: :desc).limit(10).map do |tax|
              li link_to(tax.id, admin_tax_path(tax))
            end
          end
        end
      end

      column do
        panel "Recent Statuses" do
          ul do
            Status.order(created_at: :desc).limit(10).map do |status|
              li link_to(status.id, admin_status_path(status))
            end
          end
        end
      end
    end
  end # content
end



# Register other models
ActiveAdmin.register Order
ActiveAdmin.register Item
ActiveAdmin.register User
ActiveAdmin.register Category
ActiveAdmin.register AdminUser
ActiveAdmin.register OrderItem
ActiveAdmin.register Tax
ActiveAdmin.register Status

