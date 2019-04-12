MAVEN_LINK="http://mirrors.standaloneinstaller.com/apache/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz"

cd /root/Downloads
if [ -d "/opt/apache-maven.3.6.0" ] 
then
    echo "Maven déjà existant" 
else
    wget $MAVEN_LINK
	ar xf apache-maven-3.6.0-bin.tar.gz
	mv apache-maven-3.6.0 /opt
fi
if [ -d "/opt/jdk1.8.0_201" ] 
then
    echo "Java déjà existant" 
else   
	tar xf jdk-8u201-linux-x64.tar.gz
	mv jdk1.8.0_201 /opt
fi
if [ -e "/etc/profile.d/maven.sh"]
then
	"maven déjà configuré"
else
	touch /etc/profile.d/maven.sh
	cat >/etc/profile.d/maven.sh <<EOL
	export JAVA_HOME=/usr/lib/jvm/jre-openjdk
	export M2_HOME=/opt/apache-maven.3.6.0/bin
	export MAVEN_HOME=/opt/apache-maven.3.6.0/bin
	export PATH=${M2_HOME}/bin:${PATH}:jdk1.8.0_201/bin
EOL
. /etc/profile
fi

mvn -v
if $? -eq 0
then
	echo "installation terminée"
fi