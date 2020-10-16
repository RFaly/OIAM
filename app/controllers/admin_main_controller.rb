class AdminMainController < ApplicationAdminController
  before_action :authenticate_admin!

  def messaging

  end

  def show_messaging
    @cadre = Cadre.find_by_id(params[:id])
    @contactCadre = current_admin.contact_admin_cadres
    @contact = ContactAdminCadre.find_by(cadre: @cadre, admin:current_admin)
    if @contact.nil?
      @contact = ContactAdminCadre.create(cadre: @cadre, admin:current_admin)
    end
    @contact.message_admin_cadres.where(admin_see:false).update(admin_see:true)
    @messages = @contact.message_admin_cadres.order(created_at: :ASC)
    @newMessage = MessageAdminCadre.new
  end

  def post_messaging
    @admin = current_admin
    @cadre = Cadre.find_by_id(params[:id])
    @contactCadre = current_admin.contact_admin_cadres
    @contact = ContactAdminCadre.where(cadre: @cadre, admin:current_admin)
    if @contact.nil?
      @contact = ContactAdminCadre.create(cadre: @cadre, admin:current_admin)
    end
    @contact.message_admin_cadres.where(admin_see:false).update(admin_see:true)
    @content = params[:message_admin_cadre][:content]
    @newMessage = MessageAdminCadre.new(content:@content, cadre_see: false, contact_admin_cadre: @contact, is_admin: true)
    if @newMessage.save
      @contact.message_admin_cadres.update(cadre_see: false )
      redirect_to admin_show_messaging_path(@admin)
    else
      flash[:alert] = @newMessage.errors.details
    end
  end
 def message_candidat
    @admin = Admin.all
    @cadre = Cadre.find_by_id(params[:id])
    @contactCadre = current_admin.contact_admin_cadres
    @contact = ContactAdminCadre.where(cadre: @cadre, admin:current_admin)
    if @contact.count == 0
      @contact = ContactAdminCadre.create(cadre: @cadre, admin:current_admin)
    else
      @contact = @contact.first
    end
    @contact.message_admin_cadres.where(admin_see:false).update(admin_see:true)
    @messages = @contact.message_admin_cadres.order(created_at: :ASC)
  end

  def message_recruteur
    @admin = Admin.all
    @client = Client.find_by_id(params[:id])
    @contactClient = current_admin.contact_admin_clients
    @contact = ContactAdminClient.where(client: @client, admin:current_admin)
    if @contact.count == 0
      @contact = ContactAdminClient.create(client: @client, admin:current_admin)
    else
      @contact = @contact.first
    end
    @contact.message_admin_clients.where(admin_see:false).update(admin_see:true)
    @messages = @contact.message_admin_clients.order(created_at: :ASC)
  end

  def show_message_recruteur
    @admin = Admin.all
    @client = Client.find_by_id(params[:id])
    @contactClient = current_admin.contact_admin_clients
    @contacts = ContactAdminClient.where(client: @client, admin:current_admin)
    if @contacts.count == 0
      @contacts = ContactAdminClient.create(client: @client, admin:current_admin)
    else
      @contacts = @contacts.first
    end
    @contacts.message_admin_clients.where(admin_see:false).update(admin_see:true)
    @message = @contacts.message_admin_clients.order(created_at: :ASC)
    @newMessage = MessageAdminClient.new
  end

  def post_message_recruteur
    @admin = current_admin
    @client = Client.all
    @contacts = ContactAdminClient.where(client: @client, admin:current_admin)
    if @contacts.count == 0
      @contacts = ContactAdminClient.create(client: @client, admin:current_admin)
    else
      @contacts = @contacts.first
    end
    @contacts.message_admin_clients.where(admin_see:false).update(admin_see:true)
    @content = params[:message_admin_client][:content]
    @newMessage = MessageAdminClient.new(content:@content, client_see: false, contact_admin_client: @contacts, is_admin: true)
    if @newMessage.save
      @contacts.message_admin_clients.update(client_see: false )
      redirect_to show_message_recruteur_path(@admin)
    else
      flash[:alert] = @newMessage.errors.details
    end
  end


  def notification
    @notifications = NotificationAdmin.order("created_at DESC")
  end

  def my_profil

  end

  def my_profil_edit
    @admin = current_admin
  end

  def update_my_profil
    @admin = current_admin
    @admin.update(params.require(:admin).permit(:first_name,:last_name,:metier,:email))
    if @admin.save
      redirect_to admin_main_my_profil_path
    else
      flash[:alert] = errorMessage
    end
  end
end
