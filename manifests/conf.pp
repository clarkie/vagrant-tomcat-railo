

file { "/etc/tomcat7/server.xml":
    owner => 'tomcat7',
    group => 'tomcat7',
    source => '/vagrant/conf/server.xml',
}
file { "/etc/tomcat7/web.xml":
    owner => 'tomcat7',
    group => 'tomcat7',
    source => '/vagrant/conf/web.xml',
}
file { "/etc/tomcat7/catalina.properties":
    owner => 'tomcat7',
    group => 'tomcat7',
    source => '/vagrant/conf/catalina.properties',
}