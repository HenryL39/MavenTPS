ARTI_LINK="https://bintray.com/jfrog/artifactory-pro/download_file?file_path=org%2Fartifactory%2Fpro%2Fjfrog-artifactory-pro%2F6.9.1%2Fjfrog-artifactory-pro-6.9.1.zip"

cd /root/Downloads
if [ -d "/opt/jfrog-artifactory-pro-6" ] 
then
    echo "Artifactory déjà existant" 
else
    wget $ARTI_LINK
	unzip jfrog-artifactory-pro-6.9.1.zip
	mv artifactory-pro-6.9.1 /opt  
fi
if [ !id artifactory ]
then
	useradd artifactory
fi
if [ -e "/opt/jfrog-artifactory-pro-6/bin/installService.sh" ]
then
	echo "service artifactory déjà configuré"
else
	/opt/jfrog-artifactory-pro-6/bin/installService.sh
	systemctl daemon-reload
	systemctl start artifactory.service
	systemctl status artifactory.service
	systemctl enable artifactory.service
fi
firewall-cmd --zone=public --add-port=8081/tcp --permanent
systemctl restart firewalld
echo "installation terminée"