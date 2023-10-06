#!/bin/bash
# ===== Easy Proxy ===========================================
# = System wide proxy settings in Ubuntu / Debian.
# ===== Version: =============================================
# = 1.0.231006
# ======Configuration: =======================================
APT_PROXY="/etc/apt/apt.conf"
APT2_PROXY="/etc/apt/apt.conf.d/proxy.conf"
WGET_PROXY="/etc/wgetrc"
RED="\e[1;31m"
GREEN="\e[1;32m"
STYLEEND="\e[0m"
TITLE="Easy Proxy Setup"
DESC="System wide proxy settings in Ubuntu / Debian."
# ============================================================
SET_PROXY() {
   echo "$TITLE"
   echo "Please enter your Proxy Address and Proxy Port"   
   echo ""
	echo -n "Proxy Address: "
	read PROXY_HOST 
	echo -n "Proxy Port: " 
	read PROXY_PORT 
   echo ""
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
   echo -e "${GREEN}Write data in $APT_PROXY...${STYLEEND}"
	cat <<-EOF| sudo tee $APT_PROXY
	Acquire::http::proxy "http://$PROXY_HOST:$PROXY_PORT/";
	Acquire::https::proxy "https://$PROXY_HOST:$PROXY_PORT/";
	Acquire::ftp::proxy "ftp://$PROXY_HOST:$PROXY_PORT/";
	Acquire::socks::proxy "socks://$PROXY_HOST:$PROXY_PORT/";
	EOF

   echo " "
   echo -e "${GREEN}Write data in $APT2_PROXY...${STYLEEND}"
	cat <<-EOF| sudo tee $APT2_PROXY
	Acquire::http::proxy "http://$PROXY_HOST:$PROXY_PORT/";
	Acquire::https::proxy "https://$PROXY_HOST:$PROXY_PORT/";
	Acquire::ftp::proxy "ftp://$PROXY_HOST:$PROXY_PORT/";
	Acquire::socks::proxy "socks://$PROXY_HOST:$PROXY_PORT/";
	EOF

   echo " "
   echo -e "${GREEN}Write data in $WGET_PROXY...${STYLEEND}"
	cat <<-EOF| sudo tee $WGET_PROXY
	use_proxy = on
	http_proxy = http://$PROXY_HOST:$PROXY_PORT/
	https_proxy = http://$PROXY_HOST:$PROXY_PORT/
	ftp_proxy = ftp://$PROXY_HOST:$PROXY_PORT/
	EOF

   echo ""
   echo -e "${GREEN}Linux Proxy successfully installed!${STYLEEND}"
   echo -e "${GREEN}You can now Press Enter to exit${STYLEEND}"   
read
clear
}

REM_PROXY() {
	unset HTTP_PROXY
	unset HTTPS_PROXY
	unset FTP_PROXY
	unset SOCKS_PROXY
	unset NO_PROXY
	unset http_proxy
	unset https_proxy
	unset ftp_proxy
	unset socks_proxy
	unset no_proxy
	gsettings set org.gnome.system.proxy.http host ''
	gsettings set org.gnome.system.proxy.http port 0
	gsettings set org.gnome.system.proxy.https host ''
	gsettings set org.gnome.system.proxy.https port 0
	gsettings set org.gnome.system.proxy.ftp host ''
	gsettings set org.gnome.system.proxy.ftp port 0
	gsettings reset org.gnome.system.proxy ignore-hosts
	gsettings set org.gnome.system.proxy mode 'none'
	gsettings list-recursively org.gnome.system.proxy
	echo -n ""|sudo tee $APT_PROXY
	echo -n ""|sudo tee $APT2_PROXY
	echo -n ""|sudo tee $WGET_PROXY
   echo ""
   echo -e "${GREEN}Linux Proxy successfully removed!${STYLEEND}"
   echo -e "${GREEN}You can now Press Enter to exit${STYLEEND}"   

read
clear
}

MENU_ERROR() {
   echo ""
   echo -e "${RED}ERROR!${STYLEEND}"
   echo -e "${RED}Wrong selection!${STYLEEND}"   

read
clear
}

until [ "$SELECT" = "0" ]; do
clear
   echo "# == $TITLE"
   echo "# == $DESC"
   echo "# ============================================================"
	echo "  1. Install Proxy" 
	echo "  2. Remove Proxy"
	echo "  3. Quit!"
	echo ""
	echo -n "  Enter selection: "
read SELECT

case $SELECT in
	1 ) clear ; SET_PROXY ;;
	2 ) clear ; REM_PROXY ;;
	3 ) clear ; exit ;;
	* ) clear ; MENU_ERROR ;;
   esac
done
