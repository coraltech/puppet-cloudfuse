
define cloudfuse::mount (

  $mount_config          = $cloudfuse::params::mount_config,
  $kernel_loaded_modules = $cloudfuse::params::kernel_loaded_modules,
  $mount_path            = $cloudfuse::params::mount_path,
  $gid                   = $cloudfuse::params::gid,
  $umask                 = $cloudfuse::params::umask,
  $auth_url              = $cloudfuse::params::auth_url,
  $cache_timeout         = $cloudfuse::params::cache_timeout,
  $cloud_user            = $cloudfuse::params::cloud_user,
  $cloud_api_key         = $cloudfuse::params::cloud_api_key,
  $container             = $cloudfuse::params::container,

) {

  include cloudfuse

  #-----------------------------------------------------------------------------

  file_line { "fstab entry for ${name}":
    path    => $mount_config,
    line    => "cloudfuse ${mount_path} fuse defaults,allow_other,authurl=${auth_url},use_snet=true,cache_timeout=${cache_timeout},username=${cloud_user},api_key=${cloud_api_key},container=${container} 0 0",
    require => Class['cloudfuse'],
  }

  file_line { "modules entry for ${name}":
    path    => $kernel_loaded_modules,
    line    => 'fuse',
    require => File_line["fstab entry for ${name}"]
  }
}
