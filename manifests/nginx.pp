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
}

nginx::resource::location { 'css/branding':
    ensure   => present,
    www_root => '/var/www/CPM',
    location => '/css/branding/',
    vhost    => 'cp2.retailcloud.net',
    ssl      => true,
}

nginx::resource::location { 'images/branding':
    ensure   => present,
    www_root => '/var/www/CPM',
    location => '/images/branding/',
    vhost    => 'cp2.retailcloud.net',
    ssl      => true,
}