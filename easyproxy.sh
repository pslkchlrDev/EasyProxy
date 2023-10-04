#!/bin/bash
# ===== Easy Proxy ===========================================
# = System wide proxy settings in Ubuntu / Debian.
# ===== Version: =============================================
# = 0.2.231004
# ======Configuration: =======================================
PROXY_HOST="localhost"
PROXY_PORT="8080"
APT_PROXY="/etc/apt/apt.conf"
APT2_PROXY="/etc/apt/apt.conf.d/proxy.conf"
WGET_PROXY="/etc/wgetrc"
# ============================================================
SET_PROXY() {
	gsettings set org.gnome.system.proxy mode 'manual'
	gsettings set org.gnome.system.proxy.http host "$PROXY_HOST"
	gsettings set org.gnome.system.proxy.http port "$PROXY_PORT"
	gsettings set org.gnome.system.proxy.https host "$PROXY_HOST"
	gsettings set org.gnome.system.proxy.https port "$PROXY_PORT"
	gsettings set org.gnome.system.proxy.ftp host "$PROXY_HOST"
	gsettings set org.gnome.system.proxy.ftp port "$PROXY_PORT"
	gsettings set org.gnome.system.proxy ignore-hosts "['localhost', '127.0.0.0/8', '127.0.0.1/8', '::1', '10.*.*.*']"
	export HTTP_PROXY="http://$PROXY_HOST:$PROXY_PORT/"
	export HTTPS_PROXY="https://$PROXY_HOST:$PROXY_PORT/"
	export FTP_PROXY="ftp://$PROXY_HOST:$PROXY_PORT/"
	export SOCKS_PROXY="socks://$PROXY_HOST:$PROXY_PORT/"
	export NO_PROXY="localhost,127.0.0.1,localaddress,.localdomain.com;"
	export http_proxy="http://$PROXY_HOST:$PROXY_PORT/"
	export https_proxy="https://$PROXY_HOST:$PROXY_PORT/"
	export ftp_proxy="ftp://$PROXY_HOST:$PROXY_PORT/"
	export socks_proxy="socks://$PROXY_HOST:$PROXY_PORT/"
	export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com;"

   echo " "
   echo "Write data in $APT_PROXY..."
	cat <<-EOF| sudo tee $APT_PROXY
	Acquire::http::proxy "http://$PROXY_HOST:$PROXY_PORT/";
	Acquire::https::proxy "https://$PROXY_HOST:$PROXY_PORT/";
	Acquire::ftp::proxy "ftp://$PROXY_HOST:$PROXY_PORT/";
	Acquire::socks::proxy "socks://$PROXY_HOST:$PROXY_PORT/";
	EOF

   echo " "
   echo "Write data in $APT2_PROXY..."
	cat <<-EOF| sudo tee $APT2_PROXY
	Acquire::http::proxy "http://$PROXY_HOST:$PROXY_PORT/";
	Acquire::https::proxy "https://$PROXY_HOST:$PROXY_PORT/";
	Acquire::ftp::proxy "ftp://$PROXY_HOST:$PROXY_PORT/";
	Acquire::socks::proxy "socks://$PROXY_HOST:$PROXY_PORT/";
	EOF

   echo " "
   echo "Write data in $WGET_PROXY..."
	cat <<-EOF| sudo tee $WGET_PROXY
	use_proxy = on
	http_proxy = http://$PROXY_HOST:$PROXY_PORT/
	https_proxy = http://$PROXY_HOST:$PROXY_PORT/
	ftp_proxy = ftp://$PROXY_HOST:$PROXY_PORT/
	EOF

   echo ""
   echo "Linux Proxy successfully installed! You can now Press Enter to exit"
read
clear
}

MENU_ERROR() {
   echo " ERROR! Incorrect selection!"
read
clear
}

until [ "$SELECT" = "0" ]; do
clear
   echo "# == Main Menu: Proxy Setup "
	echo "  1. Install Proxy" 
	echo "  2. Quit!"
	echo ""
	echo -n "  Enter selection: "
read SELECT

case $SELECT in
	1 ) clear ; SET_PROXY ;;
	2 ) clear ; exit ;;
	* ) clear ; MENU_ERROR ;;
   esac
done
	ftp_proxy = ftp://$PROXY_HOST:$PROXY_PORT/
	EOF

echo ""
echo "Proxy Settings successfully updated"
