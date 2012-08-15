
class cloudfuse::default {

  $dev_ensure    = 'present'
  $source        = 'git://github.com/redbo/cloudfuse.git'
  $revision      = 'master'

  $gid           = 0
  $umask         = 007
  $auth_url      = 'https://auth.api.rackspacecloud.com/v1.0'
  $cache_timeout = '300'

  $cloud_user    = ''
  $cloud_api_key = ''

  #---

  case $::operatingsystem {
    debian, ubuntu: {
      $dev_packages          = [ 'libfuse-dev' ]

      $repo                  = '/usr/local/lib/cloudfuse'

      $kernel_loaded_modules = '/etc/modules'

      $mount_config          = '/etc/fstab'
      $mount_home            = '/media'
      $mount_cmd             = '/bin/mount -a'
    }
    default: {
      fail("The cloudfuse module is not currently supported on ${::operatingsystem}")
    }
  }
}
