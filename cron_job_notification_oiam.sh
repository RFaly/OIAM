#!/bin/bash

while true
do
	/bin/sleep 5
	/bin/curl -k http://c8b0600.online-server.cloud/727562792f67656dnotifed_cron_job732f322e372e302f.json
done

# http://localhost:3000/727562792f67656dnotifed_cron_job732f322e372e302f.json
# http://fc16455.online-server.cloud/727562792f67656dnotifed_cron_job732f322e372e302f.json
# http://c8b0600.online-server.cloud/727562792f67656dnotifed_cron_job732f322e372e302f.json

# ./cron_job_notification_oiam.sh

# sudo chmod +x cron_job_notification_oiam

# create a service in /etc/systemd/system/name_service.service

# [Unit]
# Description=Run Cron Notification App OIAM
# After=network.target
# StartLimitIntervalSec=0
# [Service]
# Type=simple
# Restart=always
# RestartSec=1
# User=root
# ExecStart=/bin/bash /root/cron_job_notification_oiam.sh

# [Install]
# WantedBy=multi-user.target

# systemctl start cron_job_notification_oiam

# systemctl enable cron_job_notification_oiam
