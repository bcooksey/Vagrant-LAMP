import 'apache'
import 'mysql'

node default {
  include dev_tools 
  include dev_env 
  include db
  include secret_app_setup
}

class dev_tools {

    package { 'vim-enhanced': ensure => installed }
    package { 'git': ensure => installed }
    package { 'subversion': ensure => installed }
}

class dev_env {
    class {'apache': }

    class { 'apache::mod::php': }

    apache::vhost { 'my-box':
        priority => '1',
        port     => '80',
        docroot  => '/var/www/html',
        override => 'All',
    }

    php::module { [ 'mysql', 'ldap', 'pdo' ]: }

    service { 'iptables':
        ensure => stopped
    }
}

class db {
    class { 'mysql::server':
        config_hash => {
            'root_password' => ''
        }
    }
}
