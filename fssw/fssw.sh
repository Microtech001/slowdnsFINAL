wget -q -O /etc/systemd/system/ws-tls.service "https://raw.githubusercontent.com/NevermoreSSH/hop/main/websocket/ws-tls.service" && chmod +x /etc/systemd/system/ws-tls.service
wget -q -O /usr/local/bin/ws-tls "https://raw.githubusercontent.com/NevermoreSSH/hop/main/websocket/ws-tls" && chmod +x /usr/local/bin/ws-tls
wget -q -O /etc/stunnel5/stunnel5.conf "https://raw.githubusercontent.com/NevermoreSSH/FIX/main/stunnel5.conf" && chmod +x /etc/stunnel5/stunnel5.conf

# Settings SSLH
cat > /etc/default/sslh <<-END
# Default options for sslh initscript
# sourced by /etc/init.d/sslh

# Disabled by default, to force yourself
# to read the configuration:
# - /usr/share/doc/sslh/README.Debian (quick start)
# - /usr/share/doc/sslh/README, at "Configuration" section
# - sslh(8) via "man sslh" for more configuration details.
# Once configuration ready, you *must* set RUN to yes here
# and try to start sslh (standalone mode only)

RUN=yes

# binary to use: forked (sslh) or single-thread (sslh-select) version
# systemd users: don't forget to modify /lib/systemd/system/sslh.service
DAEMON=/usr/sbin/sslh

DAEMON_OPTS="--user sslh --listen 0.0.0.0:443 --ssl 127.0.0.1:777 --ssh 127.0.0.1:109 --openvpn 127.0.0.1:1194 --http 127.0.0.1:8880 --pidfile /var/run/sslh/sslh.pid -n"

END

# Restart Service SSLH
service sslh restart
systemctl restart sslh
/etc/init.d/sslh restart
/etc/init.d/sslh status
/etc/init.d/sslh restart
