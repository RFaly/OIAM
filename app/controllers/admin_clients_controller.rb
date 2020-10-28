class AdminClientsController < ApplicationAdminController
	before_action :authenticate_admin!
	
  def be_processed
  end

  def pending
  end

  def processed
  end

  def messaging
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
    @newMessage = MessageAdminClient.new
  end

  def show_message
    @client = Client.find_by_id(params[:id])
    @contact = ContactAdminClient.find_by(client: @client, admin:current_admin)
    if @contact.nil?
      @contact = ContactAdminClient.create(client: @client, admin:current_admin)    
    else
      @contact.message_admin_clients.where(admin_see:false).update(admin_see:true)
    end
    @messages = @contact.message_admin_clients.order(created_at: :ASC)
    @newMessage = MessageAdminClient.new
  end

  def post_message
    @client = Cadre.find_by_id(params[:id_client])
    @contact = ContactAdminClient.find_by(id: params[:id_contact], admin: current_admin, client: @client)
    @content = params[:message_admin_client][:content]
    @newMessage = MessageAdminClient.new(content:@content, client_see: false, contact_admin_client: @contact, is_admin: true)
    @contact.message_admin_clients.where(admin_see:false).update(admin_see:true)
    if @newMessage.save      
      redirect_to clients_show_message_path(@client)
    else
        flash[:alert] = @newMessage.errors.details
      redirect_back(fallback_location: root_path)
    end
  end
end
