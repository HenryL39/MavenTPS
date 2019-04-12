NEXUS_LINK="https://download.sonatype.com/nexus/3/latest-unix.tar.gz"

cd /root/Downloads
if [ -d /opt/nexus-3.16.0-01 ]
then
	echo "nexus installé"
else
	wget $NEXUS_LINK
	tar xf latest-unix.tar.gz
	mv nexus-3.16.0-01 /opt/
	mv sonatype-work /opt/
	useradd nexus
	chown -R nexus:nexus /opt/nexus-3.16.0-01
	chown -R nexus:nexus /opt/sonatype-work
fi

if [ -e /etc/systemd/system/nexus.service ]
then
	echo "service nexus configuré"
else
	touch /etc/systemd/system/nexus.service
	cat >/etc/systemd/system/nexus.service <<EOL
	[Unit]
	Description=nexus service
	After=network.target
	  
	[Service]
	Type=forking
	LimitNOFILE=65536
	ExecStart=/opt/nexus-3.16.0-01/bin/nexus start
	ExecStop=/opt/nexus-3.16.0-01/bin/nexus stop
	User=nexus
	Restart=on-abort
	  
	[Install]
	WantedBy=multi-user.target
EOL
fi
systemctl daemon-reload
systemctl start nexus.service
systemctl status nexus.service
systemctl enable nexus.service
firewall-cmd --permanent --add-port=8081/tcp
systemctl restart firewalld

echo "installation finie"