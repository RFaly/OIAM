class AdminCandidatsController < ApplicationAdminController
	before_action :authenticate_admin!

  def be_processed
  end

  def pending
  end

  def processed
  end

  def messaging
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

  def show_message
    @cadre = Cadre.find_by_id(params[:id])
    @contact = ContactAdminCadre.find_by(cadre: @cadre, admin:current_admin)
    if @contact.nil?
      @contact = ContactAdminCadre.create(cadre: @cadre, admin:current_admin)    
	else
    	@contact.message_admin_cadres.where(admin_see:false).update(admin_see:true)
	end
    @messages = @contact.message_admin_cadres.order(created_at: :ASC)
    @newMessage = MessageAdminCadre.new
  end

  def post_message
  	@cadre = Cadre.find_by_id(params[:id_cadre])
  	@contact = ContactAdminCadre.find_by(id: params[:id_contact], admin: current_admin, cadre: @cadre)
    @content = params[:message_admin_cadre][:content]
    @newMessage = MessageAdminCadre.new(content:@content, cadre_see: false, contact_admin_cadre: @contact, is_admin: true)
    @contact.message_admin_cadres.where(admin_see:false).update(admin_see:true)
    if @newMessage.save      
      	redirect_to candidats_show_message_path(@cadre)
    else
      	flash[:alert] = @newMessage.errors.details
     	redirect_back(fallback_location: root_path)
    end
  end
end

=begin

#tous les candidats
@cadre_infos = CadreInfo.all

#cadre non admis
@cadre_infos = CadreInfo.where(is_recrute:false)

#cadre admis
@cadre_infos = CadreInfo.where(is_recrute:true)

# entretien fit
@cadre_infos = CadreInfo.where(is_recrute:nil).where.not(score_potential:nil)

=end