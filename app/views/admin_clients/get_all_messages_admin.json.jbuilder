json.array! @messages do |message|
	json.id message.id 
	json.content message.content
	json.is_admin message.is_admin 
end
# json.created_at message.created_at 
# json.updated_at message.updated_at 
# json.contact_admin_cadre_id message.contact_admin_cadre_id 
