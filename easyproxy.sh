#!/bin/bash
# ===== Easy Proxy ===========================================
# = System wide proxy settings in Ubuntu / Debian.
# ===== Version: =============================================
# = 0.1.230928
# ======Configuration: =======================================
PROXY_HOST="localhost"
PROXY_PORT="8080"
# ============================================================
# global proxy settings 
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
    
# Write data in /etc/apt/apt.conf
   echo "write data in /etc/apt/apt.conf"
	cat <<-EOF| sudo tee /etc/apt/apt.conf
	Acquire::http::proxy "http://$PROXY_HOST:$PROXY_PORT/";
	Acquire::https::proxy "https://$PROXY_HOST:$PROXY_PORT/";
	Acquire::ftp::proxy "ftp://$PROXY_HOST:$PROXY_PORT/";
	Acquire::socks::proxy "socks://$PROXY_HOST:$PROXY_PORT/";
	EOF

# Write data in /etc/apt/apt.conf.d/proxy.conf
   echo " "
   echo "write data in /etc/apt/apt.conf.d/proxy.conf"
	cat <<-EOF| sudo tee /etc/apt/apt.conf.d/proxy.conf
	Acquire::http::proxy "http://$PROXY_HOST:$PROXY_PORT/";
	Acquire::https::proxy "https://$PROXY_HOST:$PROXY_PORT/";
	Acquire::ftp::proxy "ftp://$PROXY_HOST:$PROXY_PORT/";
	Acquire::socks::proxy "socks://$PROXY_HOST:$PROXY_PORT/";
	EOF

# Write data in /etc/etc/wgetrc
   echo " "
   echo "write data in /etc/apt/apt.conf.d/proxy.conf"
	cat <<-EOF| sudo tee /etc/apt/apt.conf.d/proxy.conf
	use_proxy = on
	http_proxy = http://$PROXY_HOST:$PROXY_PORT/
	https_proxy = http://$PROXY_HOST:$PROXY_PORT/
	ftp_proxy = ftp://$PROXY_HOST:$PROXY_PORT/
	EOF

echo ""
echo "Proxy Settings successfully updated"
