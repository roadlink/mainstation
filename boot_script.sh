#! /bin/sh
#setup simcard
cp ./lib/enter_pin.sh /home/pi/enter_pin.sh
chmod +x /home/pi/enter_pin.sh
cp ./lib/enter_pin.service /etc/systemd/system/enter_pin.service
systemctl enable enter_pin.service
systemctl start enter_pin

#wifi ap
apt-get update
apt-get upgrade
apt-get dist-upgrade
apt-get install -y udhcpd hostapd openssl iptables-persistent
systemctl stop udhcpd
systemctl stop hostapd
cp ./lib/udhcpd.conf /etc/udhcpd.conf
cp ./lib/hostapd.conf /etc/hostapd/hostapd.conf
#DAEMON_CONF="/etc/hostapd/hostapd.conf"  add to /etc/default/hostapd
#DHCPD_ENABLED="no" comment in /etc/default/udhcpd
cp ./lib/interfaces /etc/network/interfaces
cp ./lib/interfaces.d/* /etc/network/interfaces.d/*
/etc/init.d/networking restart
sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
#net.ipv4.ip_forward=1 add to /etc/sysctl.conf
iptables -t nat -A POSTROUTING -o usb0 -j MASQUERADE
iptables -A FORWARD -i usb0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i wlan0 -o usb0 -j ACCEPT
sh -c "iptables-save > /etc/iptables.ipv4.nat"
# add to /etc/network/interfaces