

/* basic nginx vhost pointing to CP2 folder */

host { 'cp2.retailcloud.net':
        ip => '127.0.0.1',
}

/* basic tomcat 7 setup */
class { 'tomcat': }
# source_dir       => "puppet:///modules/tomcat/conf/",

class { 'nginx': }
nginx::resource::upstream { 'railo':
 ensure  => present,
 members => [
   'localhost:8080',
 ],
}

nginx::resource::vhost { 'cp2.retailcloud.net':
  ensure => present,
  proxy  => 'http://railo',
  ssl         => 'true',
  ssl_cert    => '/vagrant/conf/server.crt',
  ssl_key     => '/vagrant/conf/server.key',
  ssl_port    => 443,
}

/*nginx::resource::vhost { 'cp2.retailcloud.net':
  ensure => present,
  www_root => '/var/www/CP2',
  ssl         => 'true',
  ssl_cert    => '/vagrant/conf/server.crt',
  ssl_key     => '/vagrant/conf/server.key',
  listen_port => 443,
  ssl_port    => 443,
  
}*/


package { 'htop': 
    ensure  => present,
}


