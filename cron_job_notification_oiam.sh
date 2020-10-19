#!/bin/bash

while true
do
	/bin/sleep 5
	/bin/curl -k http://localhost:3000/notifed_entretien_client_fit.json
done

# sudo chmod +x /my_sh_file.sh
