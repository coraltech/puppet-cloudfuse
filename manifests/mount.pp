
define cloudfuse::mount (

  $mount_config          = $cloudfuse::params::mount_config,
  $kernel_loaded_modules = $cloudfuse::params::kernel_loaded_modules,
  $mount_dir             = "${cloudfuse::params::mount_home}/${name}",
  $gid                   = $cloudfuse::params::gid,
  $umask                 = $cloudfuse::params::umask,
  $auth_url              = $cloudfuse::params::auth_url,
  $cache_timeout         = $cloudfuse::params::cache_timeout,
  $cloud_user            = $cloudfuse::params::cloud_user,
  $cloud_api_key         = $cloudfuse::params::cloud_api_key,
  $mount_cmd             = $cloudfuse::params::mount_cmd,

) {

  include cloudfuse

  #-----------------------------------------------------------------------------

  file { "${name}-mount-dir":
    path    => $mount_dir,
    ensure  => directory,
    require => Class['cloudfuse'],
  }

  file_line { "${name}-fstab":
    path    => $mount_config,
    line    => "cloudfuse ${mount_dir} fuse defaults,allow_other,authurl=${auth_url},use_snet=true,cache_timeout=${cache_timeout},username=${cloud_user},api_key=${cloud_api_key} 0 0",
    require => File["${name}-mount-dir"],
  }

  file_line { "${name}-modules":
    path    => $kernel_loaded_modules,
    line    => 'fuse',
    require => File_line["${name}-fstab"]
  }

  exec { "${name}-mount":
    command     => $mount_cmd,
    refreshonly => true,
    subscribe   => File_line["${name}-modules"]
  }
}
