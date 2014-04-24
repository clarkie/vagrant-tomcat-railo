# railo.pp

/* define the railo version you want here: */
$railoVersion = "4.1.1.009"
$warFileName = "railo-${railoVersion}.war"

/* update all packages */
exec { "apt-get":
	command	=> "/usr/bin/apt-get update",
}

/* get htop */
package { "htop": 
	ensure	=> present,
	require	=> Exec["apt-get"],
}

package { "curl": 
	ensure	=> present,
	require	=> Exec["apt-get"],
}

/* add cp2 to to the hosts file */
host { "cp2.retailcloud.net":
	ip	=> "127.0.0.1",
}


/* nginx proxy pointing to tomcat on 8080 */
class { "nginx": }
nginx::resource::upstream { "railo":
	ensure	=> present,
	members	=> [
		"localhost:8080",
	],
}

/* nginx vhost using proxy + self signed ssl */
nginx::resource::vhost {
	"cp2.retailcloud.net":
		ensure   => present,
		proxy    => "http://railo",
		ssl      => true,
		ssl_cert => "/vagrant/conf/server.crt",
		ssl_key  => "/vagrant/conf/server.key",
		ssl_port => 443;
	"monitor.local":
		ensure   => present,
		proxy    => "http://railo",
		ssl      => true,
		ssl_cert => "/vagrant/conf/server.crt",
		ssl_key  => "/vagrant/conf/server.key",
		ssl_port => 443;
}

/* make sure tomcat is installed */
package {"tomcat7":
	ensure	=> installed,
	require	=> Package["curl"],
}

/* once tomcat is installed */
service { "tomcat7":
	ensure  => "running",
	enable  => "true",
	require => Package["tomcat7"],
}

/* download the railo war */
exec { "railo-download": 
  command => "/usr/bin/wget --quiet http://www.getrailo.org/railo/remote/download/${railoVersion}/custom/all/${warFileName}",
  cwd => "/home/vagrant/",
  creates => "/home/vagrant/${warFileName}",
  require => Package['tomcat7'],
}

/* stick the railo war file into tomcat */
file { "railo.war":
	name	=> "/var/lib/tomcat7/webapps/railo.war",
	owner	=> "tomcat7",
	group	=> "tomcat7",
	source	=> "/home/vagrant/${warFileName}",
	require	=> Exec["railo-download"],
}

/* prod tomcat */
exec { "curl":
	name		=> "/usr/bin/curl localhost:8080",
	require		=> File["railo.war"],
	notify		=> Service["tomcat7"],
}
