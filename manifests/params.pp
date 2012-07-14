
class cloudfuse::params {

  #-----------------------------------------------------------------------------

  $cloudfuse_source    = 'git://github.com/redbo/cloudfuse.git'
  $cloudfuse_revision  = 'master'

  $gid                   = 0
  $umask                 = 007
  $auth_url              = 'https://auth.api.rackspacecloud.com/v1.0'
  $cache_timeout         = '300'
  $cloud_user            = ''
  $cloud_api_key         = ''
  $container             = 'public'

  case $::operatingsystem {
    debian, ubuntu: {
      $libfuse_dev_package = 'libfuse-dev'
      $libfuse_dev_version = 'latest'

      $cloudfuse_repo      = '/tmp/cloudfuse'

      $kernel_loaded_modules = '/etc/modules'
      $mount_config          = '/etc/fstab'
      $mount_path            = '/media/cloudfuse'
    }
    centos, redhat: {}
  }
}
