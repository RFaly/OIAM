json.array! @messages do |message|
	json.id message.id
  json.content message.content
  json.is_client message.is_client
end
