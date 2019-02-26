#! /bin/sh
sleep 4
wget -S --post-data "isTest=false&goformId=ENTER_PIN&PinNumber=XXXX" http://192.168.0.1/goform/goform_set_cmd_process -O /tmp/response
return 0