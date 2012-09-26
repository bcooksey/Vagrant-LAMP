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
    package { 'man-pages-overrides': ensure => installed }
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

    # TODO: Add this command to get newer version of php
    #     rpm -Uvh http://yum.thelinuxfix.com/RHEL/6/x86_64/tlf-release-1-2.el6.noarch.rpm
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
