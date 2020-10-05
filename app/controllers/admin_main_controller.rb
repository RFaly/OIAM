class AdminMainController < ApplicationAdminController
  before_action :authenticate_admin!
  def home
  end

  def messaging
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

  def show_messaging
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
    @newMessage = MessageAdminCadre.new
  end

  def post_messaging
    @admin = current_admin
    @cadre = Cadre.all
    @contact = ContactAdminCadre.where(cadre: @cadre, admin:current_admin)
    if @contact.count == 0
      @contact = ContactAdminCadre.create(cadre: @cadre, admin:current_admin)
    else
      @contact = @contact.first
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



  def notification
    @notifications = current_admin.notifications.order("created_at DESC")
  end

  def my_profil
  	
  end
end
