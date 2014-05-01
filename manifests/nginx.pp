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

nginx::resource::location {
	'css/branding':
		ensure   => present,
		www_root => '/var/www/branding',
		location => '/css/branding/',
		vhost    => 'cp2.retailcloud.net',
		ssl      => true;
	'images/branding':
		ensure   => present,
		www_root => '/var/www/branding',
		location => '/images/branding/',
		vhost    => 'cp2.retailcloud.net',
		ssl      => true;
	'favicon.ico':
		ensure   => present,
		www_root => '/var/www/branding',
		location => '/favicon.ico',
		vhost    => 'cp2.retailcloud.net',
		ssl      => true;
}

nginx::resource::location {
	'jpg_rgb_150px':
		ensure   => present,
		www_root => '/var/client-filestore/CPM_ConcretePlatform',
		location => '/jpg_rgb_150px',
		vhost    => 'cp2.retailcloud.net',
		ssl      => true;
	'jpg_rgb_500px':
		ensure   => present,
		www_root => '/var/client-filestore/CPM_ConcretePlatform',
		location => '/jpg_rgb_500px',
		vhost    => 'cp2.retailcloud.net',
		ssl      => true;
}
