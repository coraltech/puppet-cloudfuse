
class cloudfuse::params {

  include cloudfuse::default

  #-----------------------------------------------------------------------------
  # General configurations

  if $::hiera_ready {
    $dev_ensure         = hiera('cloudfuse_dev_ensure', $cloudfuse::default::dev_ensure)
    $cloudfuse_source   = hiera('cloudfuse_source', $cloudfuse::default::cloudfuse_source)
    $cloudfuse_revision = hiera('cloudfuse_revision', $cloudfuse::default::cloudfuse_revision)
    $gid                = hiera('cloudfuse_gid', $cloudfuse::default::gid)
    $umask              = hiera('cloudfuse_umask', $cloudfuse::default::umask)
    $auth_url           = hiera('cloudfuse_auth_url', $cloudfuse::default::auth_url)
    $cache_timeout      = hiera('cloudfuse_cache_timeout', $cloudfuse::default::cache_timeout)
    $cloud_user         = hiera('cloudfuse_user', $cloudfuse::default::cloud_user)
    $cloud_api_key      = hiera('cloudfuse_api_key', $cloudfuse::default::cloud_api_key)
    $container          = hiera('cloudfuse_container', $cloudfuse::default::container)
  }
  else {
    $dev_ensure         = $cloudfuse::default::dev_ensure
    $cloudfuse_source   = $cloudfuse::default::cloudfuse_source
    $cloudfuse_revision = $cloudfuse::default::cloudfuse_revision
    $gid                = $cloudfuse::default::gid
    $umask              = $cloudfuse::default::umask
    $auth_url           = $cloudfuse::default::auth_url
    $cache_timeout      = $cloudfuse::default::cache_timeout
    $cloud_user         = $cloudfuse::default::cloud_user
    $cloud_api_key      = $cloudfuse::default::cloud_api_key
    $container          = $cloudfuse::default::container
  }

  #-----------------------------------------------------------------------------
  # Operting system specific configurations

  case $::operatingsystem {
    debian, ubuntu: {
      $os_dev_packages          = [ 'libfuse-dev', 'libxml2-dev' ]

      $os_cloudfuse_repo        = '/usr/local/lib/cloudfuse'

      $os_kernel_loaded_modules = '/etc/modules'
      $os_mount_config          = '/etc/fstab'
      $os_mount_dir             = '/media/cloudfuse'
    }
    default: {
      fail("The cloudfuse module is not currently supported on ${::operatingsystem}")
    }
  }
}
