
class cloudfuse::params inherits cloudfuse::default {

  $repo                  = module_param('repo')
  $source                = module_param('source')
  $revision              = module_param('revision')
  $dev_packages          = module_param('dev_packages')
  $dev_ensure            = module_param('dev_ensure')

  #---

  $kernel_loaded_modules = module_param('kernel_loaded_modules')

  $mount_config          = module_param('mount_config')
  $mount_home            = module_param('mount_home')
  $mount_cmd             = module_param('mount_cmd')

  #---

  $gid                   = module_param('gid')
  $umask                 = module_param('umask')
  $auth_url              = module_param('auth_url')
  $cache_timeout         = module_param('cache_timeout')
  $cloud_user            = module_param('cloud_user')
  $cloud_api_key         = module_param('cloud_api_key')
}
