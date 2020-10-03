ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
     columns do
       column do
         panel "Usuarios Registrados" do
             User.all.each do |user|
          
             end
             table_for User.all.order("id desc").limit(10) do
              #image_tag("user_photo")
              column("user_name") 
              column("email") 
              column("created_at")
              #default_actions
              column("Editar") do 
                link_to('Editar',edit_user_registration_path(User))
              end
              column("Eliminar") do 
              link_to('Eliminar','www.emol.com')
              end 
            end
         end
       end
      end 





    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
  
  
end
