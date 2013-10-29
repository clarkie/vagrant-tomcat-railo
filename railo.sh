
# railo.sh
service tomcat7 stop

ls -al /vagrant/conf/railo.war
cp /vagrant/conf/railo.war /var/lib/tomcat7/webapps/railo.war

ls -al /var/lib/tomcat7/webapps/railo.war

service tomcat7 start

mkdir /usr/share/tomcat7/railo

wget cp2.retailcloud.net/index.cfm
rm index.cfm

cp -R /var/lib/tomcat7/webapps/railo/WEB-INF/lib/* /usr/share/tomcat7/railo

chown -R tomcat7.tomcat7 /usr/share/tomcat7/railo

service tomcat7 stop

rm -rf /var/lib/tomcat7/webapps/railo/  /var/lib/tomcat7/webapps/railo.war

# start tomcat again
service tomcat7 start


# reload nginx config 
service nginx reload

netstat -ntlp
