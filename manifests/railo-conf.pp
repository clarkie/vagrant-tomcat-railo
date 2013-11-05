
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

 
file { 'railo-dir':
	name	=> '/var/lib/tomcat7/webapps/railo',
	ensure	=> 'directory',
	owner	=> 'tomcat7',
	group	=> 'tomcat7',
}

file { 'web-inf-dir':
	name	=> '/var/lib/tomcat7/webapps/railo/WEB-INF',
	ensure	=> 'directory',
	owner	=> 'tomcat7',
	group	=> 'tomcat7',
	require	=> File['railo-dir'],
}

file { 'lib-dir':
	name	=> '/var/lib/tomcat7/webapps/railo/WEB-INF/lib',
	ensure	=> 'directory',
	owner	=> 'tomcat7',
	group	=> 'tomcat7',
	require	=> File['web-inf-dir'],
}

file { 'railo-server-dir':
	name	=> '/var/lib/tomcat7/webapps/railo/WEB-INF/lib/railo-server',
	ensure	=> 'directory',
	owner	=> 'tomcat7',
	group	=> 'tomcat7',
	require	=> File['lib-dir'],
}

file { 'context-dir':
	name	=> '/var/lib/tomcat7/webapps/railo/WEB-INF/lib/railo-server/context',
	ensure	=> 'directory',
	owner	=> 'tomcat7',
	group	=> 'tomcat7',
	require	=> File['railo-server-dir'],
}

 file { 'railo-server.xml':
 	name	=> '/var/lib/tomcat7/webapps/railo/WEB-INF/lib/railo-server/context/railo-server.xml',
 	owner	=> 'tomcat7',
 	group	=> 'tomcat7',
 	source	=> '/vagrant/conf/railo-server.xml',
 	mode  => 644,
	require	=> File['context-dir'],
 	notify	=> Service['tomcat7'],
 }
