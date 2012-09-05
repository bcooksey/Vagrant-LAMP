import 'apache'
import 'mysql'

node default {
  include vim
  include apache_server
  include db

  service { 'iptables':
    ensure => stopped
  }
}

class vim {
  package {'vim-enhanced':
    ensure => installed
  }
  package {'git':
    ensure => installed
  }
}

class apache_server {
  class {'apache': }

  class { 'apache::mod::php': }

  apache::vhost { 'my-box':
    priority => '1',
    port     => '80',
    docroot  => '/var/www/html',
    override => 'All',
  }
  
  php::module { [ 'mysql', 'ldap', 'pdo', 'pear' ]: }
}

class db {
  class { 'mysql::server':
    config_hash       => {
      'root_password' => ''
    }
  }
}
