
service { 'tomcat7':
	ensure  => 'running',
	enable  => 'true',
}

file { '/etc/tomcat7/server.xml':
	owner	=> 'tomcat7',
	group	=> 'tomcat7',
	mode  => 644,
	source	=> '/vagrant/conf/server.xml',
	notify	=> Service['tomcat7'],
}

file { '/etc/tomcat7/web.xml':
	owner	=> 'tomcat7',
	group	=> 'tomcat7',
	mode  => 644,
	source	=> '/vagrant/conf/web.xml',
	notify	=> Service['tomcat7'],
}

file { 'catalina.properties':
	name	=> '/etc/tomcat7/catalina.properties',
	owner	=> 'tomcat7',
	group	=> 'tomcat7',
	mode  => 644,
	source	=> '/vagrant/conf/catalina.properties',
	notify	=> Service['tomcat7'],
}


 file{ ['/var/lib/tomcat7/webapps/railo',
	'/var/lib/tomcat7/webapps/railo/WEB-INF',
	'/var/lib/tomcat7/webapps/railo/WEB-INF/lib',
	'/var/lib/tomcat7/webapps/railo/WEB-INF/lib/railo-server',
	'/var/lib/tomcat7/webapps/railo/WEB-INF/lib/railo-server/context'] :
	ensure	=> 'directory',
	owner	=> 'tomcat7',
	group	=> 'tomcat7',
}

 file { 'railo-server.xml':
 	name	=> '/var/lib/tomcat7/webapps/railo/WEB-INF/lib/railo-server/context/railo-server.xml',
 	owner	=> 'tomcat7',
 	group	=> 'tomcat7',
 	source	=> '/vagrant/conf/railo-server.xml',
 	mode  => 644,
	require	=> File['/var/lib/tomcat7/webapps/railo/WEB-INF/lib/railo-server/context'],
 	notify	=> Service['tomcat7'],
 }

file { 'default.tomcat7':
	name	=> '/etc/default/tomcat7',
	owner	=> 'root',
	group	=> 'root',
	mode  => 644,
	source	=> '/vagrant/conf/default.tomcat7',
	notify	=> Service['tomcat7'],
}